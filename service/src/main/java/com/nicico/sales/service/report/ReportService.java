package com.nicico.sales.service.report;

import com.fasterxml.jackson.core.type.TypeReference;
import com.fasterxml.jackson.databind.ObjectMapper;
import com.nicico.copper.common.domain.criteria.NICICOCriteria;
import com.nicico.copper.common.domain.criteria.NICICOSqlClause;
import com.nicico.copper.common.domain.criteria.SearchUtil;
import com.nicico.copper.common.dto.grid.GridResponse;
import com.nicico.copper.common.dto.grid.TotalResponse;
import com.nicico.copper.common.dto.search.SearchDTO;
import com.nicico.copper.core.SecurityUtil;
import com.nicico.copper.oauth.common.dto.OAPermissionDTO;
import com.nicico.sales.annotation.Action;
import com.nicico.sales.annotation.report.IgnoreReportField;
import com.nicico.sales.annotation.report.Report;
import com.nicico.sales.annotation.report.ReportField;
import com.nicico.sales.annotation.report.ReportModel;
import com.nicico.sales.dto.FileDTO;
import com.nicico.sales.dto.report.ReportDTO;
import com.nicico.sales.dto.report.ReportFieldDTO;
import com.nicico.sales.enumeration.ActionType;
import com.nicico.sales.enumeration.ErrorType;
import com.nicico.sales.exception.NotFoundException;
import com.nicico.sales.exception.SalesException2;
import com.nicico.sales.exception.UnAuthorizedException;
import com.nicico.sales.iservice.IFileService;
import com.nicico.sales.iservice.IOAuthApiService;
import com.nicico.sales.iservice.report.IReportFieldService;
import com.nicico.sales.iservice.report.IReportService;
import com.nicico.sales.model.enumeration.ReportSource;
import com.nicico.sales.model.enumeration.ReportType;
import com.nicico.sales.service.GenericService;
import com.nicico.sales.utility.StringFormatUtil;
import com.nicico.sales.utility.UpdateUtil;
import io.minio.errors.*;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.modelmapper.ModelMapper;
import org.modelmapper.TypeToken;
import org.reflections.Reflections;
import org.reflections.scanners.MethodAnnotationsScanner;
import org.reflections.util.ClasspathHelper;
import org.reflections.util.ConfigurationBuilder;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.context.i18n.LocaleContextHolder;
import org.springframework.context.support.ResourceBundleMessageSource;
import org.springframework.http.*;
import org.springframework.security.core.Authentication;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.security.oauth2.provider.authentication.OAuth2AuthenticationDetails;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.util.MultiValueMap;
import org.springframework.util.ReflectionUtils;
import org.springframework.util.StringUtils;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.client.RestTemplate;
import org.springframework.web.multipart.MultipartFile;

import javax.persistence.EntityManager;
import javax.persistence.Query;
import java.io.IOException;
import java.lang.annotation.Annotation;
import java.lang.reflect.InvocationTargetException;
import java.lang.reflect.Method;
import java.math.BigDecimal;
import java.security.InvalidKeyException;
import java.security.NoSuchAlgorithmException;
import java.util.*;

@Slf4j
@Service
@RequiredArgsConstructor
public class ReportService extends GenericService<com.nicico.sales.model.entities.report.Report, Long, ReportDTO.Create, ReportDTO.Info, ReportDTO.Update, ReportDTO.Delete> implements IReportService {

    private final static String VIEW_DATA_QUERY_TEXT = "" +
            "SELECT *\n" +
            "FROM   %s\n";
    private final static String VIEW_FIELDS_NAME_QUERY_TEXT = "" +
            "SELECT\n" +
            "    COLUMN_NAME\n" +
            "FROM\n" +
            "    user_tab_columns\n" +
            "WHERE\n" +
            "    table_name = ?\n" +
            "ORDER BY COLUMN_ID";
    private final static String VIEW_NAME_QUERY_TEXT = "" +
            "SELECT TABLE_NAME\n" +
            "FROM   USER_TABLES\n" +
            "WHERE  UPPER(TABLE_NAME) NOT IN ('Z_LIQ_CHANGELOG', 'Z_LIQ_CHANGELOG_LOCK')\n" +
            "UNION ALL\n" +
            "SELECT VIEW_NAME\n" +
            "FROM   USER_VIEWS";
    private final static String[] VIEW_FIELDS_OBJECT_COLUMNS = {"className", "name", "hidden", "canFilter", "dataIsList", "type"};
    private final static String VIEW_FIELDS_QUERY_TEXT = "" +
            "SELECT\n" +
            "    TABLE_NAME              AS className,\n" +
            "    COLUMN_NAME             AS name,\n" +
            "    0                       AS hidden,\n" +
            "    1                       AS canFilter,\n" +
            "    1                       AS dataIsList,\n" +
            "    (CASE\n" +
            "        WHEN UPPER(DATA_TYPE) LIKE 'INT'\n" +
            "        THEN 'integer'\n" +
            "        WHEN UPPER(DATA_TYPE) LIKE 'LONG'\n" +
            "        THEN 'integer'\n" +
            "        WHEN UPPER(DATA_TYPE) LIKE 'INTEGER'\n" +
            "        THEN 'integer'\n" +
            "        WHEN UPPER(DATA_TYPE) LIKE 'SMALLINT'\n" +
            "        THEN 'integer'\n" +
            "        WHEN UPPER(DATA_TYPE) LIKE '%NUMBER%' AND (DATA_SCALE IS NULL OR DATA_SCALE = 0)\n" +
            "        THEN 'integer'\n" +
            "        WHEN UPPER(DATA_TYPE) LIKE '%FLOAT%'\n" +
            "        THEN 'float'\n" +
            "        WHEN UPPER(DATA_TYPE) LIKE '%DOUBLE%'\n" +
            "        THEN 'float'\n" +
            "        WHEN UPPER(DATA_TYPE) LIKE '%DECIMAL%'\n" +
            "        THEN 'float'\n" +
            "        WHEN UPPER(DATA_TYPE) LIKE '%NUMBER%' AND DATA_SCALE IS NOT NULL AND DATA_SCALE > 0\n" +
            "        THEN 'float'\n" +
            "        WHEN UPPER(DATA_TYPE) LIKE '%DATE%'\n" +
            "        THEN 'date'\n" +
            "        WHEN UPPER(DATA_TYPE) LIKE '%TIMESTAMP%'\n" +
            "        THEN 'date'\n" +
            "        ELSE 'text'\n" +
            "    END)                    AS type\n" +
            "FROM\n" +
            "    user_tab_columns\n" +
            "WHERE\n" +
            "    table_name = ?";
    private final static List<Class> MAPPING_ANNOTATIONS = new ArrayList<>(Arrays.asList(RequestMapping.class, GetMapping.class, PutMapping.class, PostMapping.class, DeleteMapping.class, PatchMapping.class));

    // -----------------------------------------------------------------------------------------------------------------

    private final UpdateUtil updateUtil;
    private final IFileService fileService;
    private final IOAuthApiService oAuthApiService;
    private final IReportFieldService reportFieldService;

    // -----------------------------------------------------------------------------------------------------------------

    private final ModelMapper modelMapper;
    private final ObjectMapper objectMapper;
    private final RestTemplate restTemplate;
    private final EntityManager entityManager;
    private final ResourceBundleMessageSource messageSource;

    // -----------------------------------------------------------------------------------------------------------------

    @Value("${spring.application.name}")
    private String appId;
    @Value("${nicico.report.package.controller.name}")
    private String restControllerPackage;

    // -----------------------------------------------------------------------------------------------------------------

    private List<ReportDTO.SourceData> getViewData() {

        Query viewNameQuery = entityManager.createNativeQuery(VIEW_NAME_QUERY_TEXT);
        List<String> viewNames = modelMapper.map(viewNameQuery.getResultList(), new TypeToken<List<String>>() {
        }.getType());

        List<ReportDTO.SourceData> viewDataList = new ArrayList<>();
        viewNames.forEach(viewName -> {

            ReportDTO.SourceData viewData = new ReportDTO.SourceData();

            viewData.setNameEN(viewName);
            viewData.setNameFA(viewName);
            viewData.setName(viewName);
            viewData.setSource(viewName);
            viewData.setDataIsList(true);

            viewDataList.add(viewData);
        });

        return viewDataList;
    }

    private List<ReportDTO.SourceData> getRestData() {

        Set<Method> methods = getSpecListMethods();

        List<ReportDTO.SourceData> restDataList = new ArrayList<>();
        methods.forEach(method -> {

            Class<?>[] parameterTypes = method.getParameterTypes();
            if (parameterTypes.length != 1 || !parameterTypes[0].equals(MultiValueMap.class))
                throw new SalesException2(ErrorType.BadRequest, method.getName(), "انوتیشن مسیریابی روی API مورد نظر درست تنظیم نشده است.");

            if (!method.getReturnType().equals(ResponseEntity.class))
                throw new SalesException2(ErrorType.BadRequest, method.getName(), "انوتیشن مسیریابی روی API مورد نظر درست تنظیم نشده است.");

            ReportDTO.SourceData restData = new ReportDTO.SourceData();

            Annotation methodMappingAnnotation = Arrays.stream(method.getAnnotations()).filter(q -> MAPPING_ANNOTATIONS.contains(q.annotationType())).findFirst().orElseThrow(() -> new NotFoundException("انوتیشن مسیریابی روی API مورد نظر درست تنظیم نشده است."));
            Map<String, String> methodData = getMethodName(methodMappingAnnotation);

            String methodUrl = getMethodUrl(method) + methodData.values().iterator().next();

            Report reportAnnotation = method.getAnnotation(Report.class);
            String nameKey = reportAnnotation.nameKey();
            restData.setNameEN(messageSource.getMessage(nameKey, null, Locale.ENGLISH));
            restData.setNameFA(messageSource.getMessage(nameKey, null, Locale.forLanguageTag("fa")));
            restData.setName(messageSource.getMessage(nameKey, null, LocaleContextHolder.getLocale()));
            restData.setDataIsList(reportAnnotation.returnTypeIsList());
            restData.setSource(methodUrl);
            restData.setRestMethod(methodData.keySet().iterator().next());

            restDataList.add(restData);
        });

        return restDataList;
    }

    private List<ReportDTO.FieldData> getViewFields(String source) {

        Query viewFieldsQuery = entityManager.createNativeQuery(VIEW_FIELDS_QUERY_TEXT);
        viewFieldsQuery.setParameter(1, source);
        List<Map<String, Object>> viewFieldMaps = new ArrayList<>();
        //noinspection unchecked
        viewFieldsQuery.getResultList().forEach(result -> {

            Object[] resultArray = ((Object[]) result);
            Map<String, Object> viewFieldMap = new HashMap<>();
            for (int i = 0; i < resultArray.length; i++)
                viewFieldMap.put(VIEW_FIELDS_OBJECT_COLUMNS[i], resultArray[i]);

            viewFieldMaps.add(viewFieldMap);
        });

        return modelMapper.map(viewFieldMaps, new TypeToken<List<ReportDTO.FieldData>>() {
        }.getType());
    }

    private List<ReportDTO.FieldData> getRestFields(String source) {

        Set<Method> methods = getSpecListMethods();
        Method sourceMethod = methods.stream().filter(method -> {

            Annotation methodMappingAnnotation = Arrays.stream(method.getAnnotations()).filter(q -> MAPPING_ANNOTATIONS.contains(q.annotationType())).findFirst().orElseThrow(() -> new NotFoundException("انوتیشن مسیریابی روی API مورد نظر درست تنظیم نشده است."));
            Map<String, String> methodData = getMethodName(methodMappingAnnotation);

            String methodUrl = getMethodUrl(method) + methodData.values().iterator().next();

            return methodUrl.equals(source);
        }).findFirst().orElseThrow(() -> new NotFoundException("متد مورد نظر یافت نشد."));

        Report reportAnnotation = sourceMethod.getAnnotation(Report.class);
        Class<?> returnType = reportAnnotation.returnType();
        List<ReportDTO.FieldData> fields = new ArrayList<>();
        getFields("", returnType, fields);

        return fields;
    }

    private Set<Method> getSpecListMethods() {

        Reflections reflections = new Reflections(new ConfigurationBuilder()
                .setUrls(ClasspathHelper.forPackage(restControllerPackage))
                .setScanners(new MethodAnnotationsScanner()));

        return reflections.getMethodsAnnotatedWith(Report.class);
    }

    private String mapType(Class<?> type) {

        if (type.equals(Boolean.class)) return "boolean";
        else if (type.equals(Byte.class)) return "integer";
        else if (type.equals(Short.class)) return "integer";
        else if (type.equals(Integer.class)) return "integer";
        else if (type.equals(Long.class)) return "integer";
        else if (type.equals(Float.class)) return "float";
        else if (type.equals(Double.class)) return "float";
        else if (type.equals(BigDecimal.class)) return "float";
        else if (type.equals(Date.class)) return "date";
        else if (type.equals(Character.class) || type.equals(String.class) || type.isEnum()) return "text";
        else return null;
    }

    private String getMethodUrl(Method method) {

        String methodUrl;
        Annotation classMappingAnnotation = Arrays.stream(method.getDeclaringClass().getAnnotations()).filter(q -> MAPPING_ANNOTATIONS.contains(q.annotationType())).findFirst().orElseThrow(() -> new NotFoundException("انوتیشن مسیریابی روی API مورد نظر درست تنظیم نشده است."));
        if (GetMapping.class.equals(classMappingAnnotation.annotationType()))
            methodUrl = ((GetMapping) classMappingAnnotation).value()[0];
        else if (PutMapping.class.equals(classMappingAnnotation.annotationType()))
            methodUrl = ((PutMapping) classMappingAnnotation).value()[0];
        else if (PostMapping.class.equals(classMappingAnnotation.annotationType()))
            methodUrl = ((PostMapping) classMappingAnnotation).value()[0];
        else if (DeleteMapping.class.equals(classMappingAnnotation.annotationType()))
            methodUrl = ((DeleteMapping) classMappingAnnotation).value()[0];
        else if (PatchMapping.class.equals(classMappingAnnotation.annotationType()))
            methodUrl = ((PatchMapping) classMappingAnnotation).value()[0];
        else
            methodUrl = ((RequestMapping) classMappingAnnotation).value()[0];

        return methodUrl;
    }

    private Map<String, String> getMethodName(Annotation methodMappingAnnotation) {

        Map<String, String> map = new HashMap<>();
        if (GetMapping.class.equals(methodMappingAnnotation.annotationType()))
            map.put("GET", ((GetMapping) methodMappingAnnotation).value()[0]);
        else if (PutMapping.class.equals(methodMappingAnnotation.annotationType()))
            map.put("PUT", ((PutMapping) methodMappingAnnotation).value()[0]);
        else if (PostMapping.class.equals(methodMappingAnnotation.annotationType()))
            map.put("POST", ((PostMapping) methodMappingAnnotation).value()[0]);
        else if (DeleteMapping.class.equals(methodMappingAnnotation.annotationType()))
            map.put("DELETE", ((DeleteMapping) methodMappingAnnotation).value()[0]);
        else if (PatchMapping.class.equals(methodMappingAnnotation.annotationType()))
            map.put("PATCH", ((PatchMapping) methodMappingAnnotation).value()[0]);
        else
            map.put(((RequestMapping) methodMappingAnnotation).method()[0].name(), ((RequestMapping) methodMappingAnnotation).value()[0]);

        return map;
    }

    private void getFields(String baseName, Class<?> returnType, List<ReportDTO.FieldData> fields) {

        ReflectionUtils.doWithFields(returnType, field -> {

            ReportDTO.FieldData fieldData = new ReportDTO.FieldData();
            ReportField reportFieldAnnotation = field.getAnnotation(ReportField.class);

            if (!StringUtils.isEmpty(baseName)) {

                fieldData.setClassName(baseName);
                fieldData.setName(baseName + "." + field.getName());
            } else
                fieldData.setName(field.getName());

            if (reportFieldAnnotation != null) {

                fieldData.setHidden(reportFieldAnnotation.hidden());
                fieldData.setCanFilter(reportFieldAnnotation.canFilter());

                String titleMessageKey = reportFieldAnnotation.titleMessageKey();
                fieldData.setTitleEN(messageSource.getMessage(titleMessageKey, null, Locale.ENGLISH));
                fieldData.setTitleFA(messageSource.getMessage(titleMessageKey, null, Locale.forLanguageTag("fa")));
            } else {

                fieldData.setHidden(false);
                fieldData.setCanFilter(true);
            }

            fieldData.setType(mapType(field.getType()));

            ReportModel reportModelAnnotation = field.getAnnotation(ReportModel.class);
            if (reportModelAnnotation != null) fieldData.setDataIsList(reportModelAnnotation.typeIsList());
            else fieldData.setDataIsList(false);
            fields.add(fieldData);

            if (reportModelAnnotation != null && reportModelAnnotation.jumpTo())
                getFields(fieldData.getName(), reportModelAnnotation.type(), fields);
        }, field -> !field.isAnnotationPresent(IgnoreReportField.class));
    }

    // -----------------------------------------------------------------------------------------------------------------

    private void addReportPermission(String permissionBaseKey, String reportTitle) {

        OAPermissionDTO.Create printPermission = new OAPermissionDTO.Create();
        printPermission.setAppId(appId);
        printPermission.setCode("RG_P_" + permissionBaseKey);
        printPermission.setTitle("چاپ " + reportTitle);
        oAuthApiService.createPermission(printPermission);

        OAPermissionDTO.Create excelPermission = new OAPermissionDTO.Create();
        excelPermission.setAppId(appId);
        excelPermission.setCode("RG_E_" + permissionBaseKey);
        excelPermission.setTitle("خروجی اکسل " + reportTitle);
        oAuthApiService.createPermission(excelPermission);

        OAPermissionDTO.Create viewPermission = new OAPermissionDTO.Create();
        viewPermission.setAppId(appId);
        viewPermission.setCode("RG_V_" + permissionBaseKey);
        viewPermission.setTitle("نمایش " + reportTitle);
        oAuthApiService.createPermission(viewPermission);
    }

    private void deleteReportPermission(String permissionBaseKey) {

        oAuthApiService.deletePermission("RG_P_" + permissionBaseKey);
        oAuthApiService.deletePermission("RG_E_" + permissionBaseKey);
        oAuthApiService.deletePermission("RG_V_" + permissionBaseKey);
    }

    // -----------------------------------------------------------------------------------------------------------------

    private HttpHeaders getApplicationJSONHttpHeaders() {

        final Authentication authentication = SecurityContextHolder.getContext().getAuthentication();
        final OAuth2AuthenticationDetails oAuth2AuthenticationDetails = (OAuth2AuthenticationDetails) authentication.getDetails();

        final HttpHeaders httpHeaders = new HttpHeaders();
        httpHeaders.setBearerAuth(oAuth2AuthenticationDetails.getTokenValue());
        httpHeaders.setContentType(MediaType.APPLICATION_JSON);
        httpHeaders.setAccept(Collections.singletonList(MediaType.APPLICATION_JSON));

        return httpHeaders;
    }

    private TotalResponse<Map<String, Object>> getRestReportData(String baseUrl, MultiValueMap<String, String> criteria, ReportDTO.Info report) throws IOException {

        TotalResponse<Map<String, Object>> response;
        String restUrl = report.getSource();
        String restMethod = report.getRestMethod();
        HttpMethod httpMethodEnum = HttpMethod.resolve(restMethod);
        if (httpMethodEnum == null)
            httpMethodEnum = HttpMethod.GET;

        HttpEntity<Object> httpEntity = new HttpEntity<>(criteria, getApplicationJSONHttpHeaders());
        ResponseEntity<String> exchange;
        try {
            exchange = restTemplate.exchange(baseUrl + restUrl, httpMethodEnum, httpEntity, String.class);
        } catch (Exception e) {
            throw new SalesException2(e, ErrorType.BadRequest, null, e.getMessage());
        }
        if (exchange.getStatusCode().equals(HttpStatus.OK)) {

            Map body = objectMapper.readValue(exchange.getBody(), Map.class);
            Map responseMap = modelMapper.map(body.get("response"), Map.class);

            GridResponse gridResponse = new GridResponse();
            gridResponse.setData((List) responseMap.get("data"));
            gridResponse.setStatus((Integer) responseMap.get("status"));
            gridResponse.setEndRow((Integer) responseMap.get("endRow"));
            gridResponse.setStartRow((Integer) responseMap.get("startRow"));
            gridResponse.setTotalRows((Integer) responseMap.get("totalRows"));
            gridResponse.setInvalidateCache((Boolean) responseMap.get("invalidateCache"));

            response = new TotalResponse(gridResponse);
        } else {

            final String message = "ReportService.getReportData Error: [" + exchange.getStatusCode() + "]: " + exchange.getBody();
            log.error(message);
            throw new SalesException2(ErrorType.BadRequest, null, message);
        }

        return response;
    }

    // -----------------------------------------------------------------------------------------------------------------

    private String getSqlWhereClause(NICICOCriteria nicicoCriteria) {

        SearchDTO.SearchRq searchRq = SearchUtil.createSearchRq(nicicoCriteria);
        NICICOSqlClause nicicoSqlClause = NICICOSqlClause.of(searchRq);

        String whereClause = nicicoSqlClause.getWhereClause();
        return StringUtils.isEmpty(whereClause) ? "" : " WHERE " + whereClause;
    }

    private List<Map<String, Object>> convertNativeQueryResultListToMap(String viewName, List queryResultList) {

        Query viewFieldsNameQuery = entityManager.createNativeQuery(VIEW_FIELDS_NAME_QUERY_TEXT);
        viewFieldsNameQuery.setParameter(1, viewName);
        List<String> viewFieldsName = modelMapper.map(viewFieldsNameQuery.getResultList(), new TypeToken<List<String>>() {
        }.getType());
        if (viewFieldsName == null || viewFieldsName.size() == 0)
            return new ArrayList<>();

        List<Map<String, Object>> viewFieldMaps = new ArrayList<>();
        //noinspection unchecked
        queryResultList.forEach(result -> {

            Object[] resultArray = ((Object[]) result);
            Map<String, Object> viewFieldMap = new HashMap<>();
            for (int i = 0; i < resultArray.length; i++)
                viewFieldMap.put(viewFieldsName.get(i), resultArray[i]);

            viewFieldMaps.add(viewFieldMap);
        });

        return viewFieldMaps;
    }

    private TotalResponse<Map<String, Object>> createTotalResponse(String viewName, NICICOCriteria nicicoCriteria, List queryResultList) {

        int totalRowsCount;
        if (nicicoCriteria.get_startRow() != null && nicicoCriteria.get_endRow() != null)
            totalRowsCount = nicicoCriteria.get_endRow() - nicicoCriteria.get_startRow();
        else {
            nicicoCriteria.set_startRow(0);
            totalRowsCount = queryResultList.size();
            nicicoCriteria.set_endRow(totalRowsCount);
        }

        GridResponse<Map<String, Object>> gridResponse = new GridResponse<>();
        gridResponse.setTotalRows(totalRowsCount);
        gridResponse.setStartRow(nicicoCriteria.get_startRow());
        gridResponse.setEndRow(nicicoCriteria.get_startRow() + totalRowsCount);
        gridResponse.setData(convertNativeQueryResultListToMap(viewName, queryResultList));

        return new TotalResponse<>(gridResponse);
    }

    private TotalResponse<Map<String, Object>> getViewReportData(MultiValueMap<String, String> criteria, ReportDTO.Info report) {

        NICICOCriteria nicicoCriteria = NICICOCriteria.of(criteria);
        String viewName = report.getSource();
        String whereClause = getSqlWhereClause(nicicoCriteria);
        String query = String.format(VIEW_DATA_QUERY_TEXT, viewName);
        String offset = " OFFSET " + nicicoCriteria.get_startRow() + " ROWS FETCH NEXT " + (nicicoCriteria.get_endRow() - nicicoCriteria.get_startRow()) + " ROWS ONLY ";
        Query viewDataQuery = entityManager.createNativeQuery(query + whereClause + offset);

        return createTotalResponse(viewName, nicicoCriteria, viewDataQuery.getResultList());
    }

    // -----------------------------------------------------------------------------------------------------------------

    @Override
    @Transactional(readOnly = true)
    public List<ReportDTO.SourceData> getSourceData(ReportSource reportSource) {

        return reportSource == ReportSource.Rest ? getRestData() : getViewData();
    }

    @Override
    @Transactional(readOnly = true)
    public List<ReportDTO.FieldData> getSourceFields(ReportSource reportSource, String source) {

        return reportSource == ReportSource.Rest ? getRestFields(source) : getViewFields(source);
    }

    @Override
    @Transactional(readOnly = true)
    public TotalResponse<Map<String, Object>> getReportData(Long reportId, String baseUrl, MultiValueMap<String, String> criteria) throws IOException {

        ReportDTO.Info report = get(reportId);
        String permissionKey = "RG_V_" + report.getPermissionBaseKey();
        if (!SecurityUtil.hasAuthority(permissionKey))
            throw new UnAuthorizedException(permissionKey);

        TotalResponse<Map<String, Object>> response = null;
        if (report.getReportSource() == ReportSource.Rest)
            response = getRestReportData(baseUrl, criteria, report);
        if (report.getReportSource() == ReportSource.View) response = getViewReportData(criteria, report);

        if (response != null &&
                response.getResponse() != null &&
                response.getResponse().getData() != null &&
                response.getResponse().getData().size() > 1 &&
                report.getReportType() == ReportType.OneRecord)
            response.getResponse().setData(response.getResponse().getData().subList(0, 1));

        return response;
    }

    // -----------------------------------------------------------------------------------------------------------------

    @Override
    @Transactional
    @Action(ActionType.Delete)
    public void delete(Long id) {

        com.nicico.sales.model.entities.report.Report report = repository.findById(id).orElseThrow(() -> new NotFoundException(Report.class));
        super.delete(id);

        deleteReportPermission(report.getPermissionBaseKey());

        List<FileDTO.FileMetaData> files = fileService.getFiles(id, Report.class.getSimpleName());
        files.forEach(q -> {
            try {
                fileService.delete(q.getFileKey());
            } catch (IOException | InvalidResponseException | InvalidKeyException | NoSuchAlgorithmException | ServerException | ErrorResponseException | XmlParserException | InvalidBucketNameException | InsufficientDataException | InternalException e) {
                throw new SalesException2(e);
            }
        });
    }

    @Override
    @Transactional(readOnly = true)
    @Action(value = ActionType.Search)
    public TotalResponse<ReportDTO.InfoWithAccess> searchWithAccess(NICICOCriteria request) {

        List<com.nicico.sales.model.entities.report.Report> entities = new ArrayList<>();
        TotalResponse<ReportDTO.InfoWithAccess> result = SearchUtil.search(repositorySpecificationExecutor, request, entity -> {

            ReportDTO.InfoWithAccess eResult = modelMapper.map(entity, ReportDTO.InfoWithAccess.class);
            eResult.setExcelAccess(SecurityUtil.hasAuthority("RG_E_" + eResult.getPermissionBaseKey()));
            eResult.setPrintAccess(SecurityUtil.hasAuthority("RG_P_" + eResult.getPermissionBaseKey()));
            eResult.setViewAccess(SecurityUtil.hasAuthority("RG_V_" + eResult.getPermissionBaseKey()));
            validation(entity, eResult);
            entities.add(entity);
            return eResult;
        });

        validationAll(entities, result);
        return result;
    }

    @Override
    @Transactional
    @Action(ActionType.Create)
    public ReportDTO.Info create(List<MultipartFile> files, String fileMetaData, String request) throws IOException, InvalidResponseException, InvalidKeyException, NoSuchAlgorithmException, ServerException, ErrorResponseException, XmlParserException, InternalException, InvalidBucketNameException, InsufficientDataException, RegionConflictException {

        ReportDTO.Create data = objectMapper.readValue(request, ReportDTO.Create.class);
        data.setPermissionBaseKey(StringFormatUtil.makeMessageKeyByRemoveSpace(data.getTitleEN(), "_").toUpperCase());
        ReportDTO.Info report = this.create(data);

        List<ReportFieldDTO.Create> reportFields = modelMapper.map(data.getFields(), new TypeToken<List<ReportFieldDTO.Create>>() {
        }.getType());
        reportFields.forEach(q -> q.setReportId(report.getId()));
        reportFieldService.createAll(reportFields);

        addReportPermission(report.getPermissionBaseKey(), report.getTitleFA());

        List<FileDTO.FileData> fileData = objectMapper.readValue(fileMetaData, new TypeReference<List<FileDTO.FileData>>() {
        });
        fileService.createFiles(report.getId(), files, fileData);

        return report;
    }

    @Override
    @Transactional
    @Action(ActionType.Update)
    public ReportDTO.Info update(List<MultipartFile> files, String fileMetaData, String request) throws IOException, InvalidResponseException, InvalidKeyException, NoSuchAlgorithmException, ServerException, ErrorResponseException, XmlParserException, InternalException, InvalidBucketNameException, InsufficientDataException, RegionConflictException, IllegalAccessException, NoSuchFieldException, InvocationTargetException {

        ReportDTO.Update data = objectMapper.readValue(request, ReportDTO.Update.class);
        ReportDTO.Info report = this.update(data);

        List<ReportFieldDTO.Create> reportFields4Insert = new ArrayList<>();
        List<ReportFieldDTO.Update> reportFields4Update = new ArrayList<>();
        ReportFieldDTO.Delete reportFields4Delete = new ReportFieldDTO.Delete();
        updateUtil.fill(
                ReportFieldDTO.Info.class,
                report.getReportFields(),
                ReportFieldDTO.Update.class,
                data.getFields(),
                ReportFieldDTO.Create.class,
                reportFields4Insert,
                ReportFieldDTO.Update.class,
                reportFields4Update,
                reportFields4Delete);

        if (!reportFields4Insert.isEmpty())
            reportFieldService.createAll(reportFields4Insert);
        if (!reportFields4Update.isEmpty())
            reportFieldService.updateAll(reportFields4Update);
        if (!reportFields4Delete.getIds().isEmpty())
            reportFieldService.deleteAll(reportFields4Delete);

        List<FileDTO.FileData> fileData = objectMapper.readValue(fileMetaData, new TypeReference<List<FileDTO.FileData>>() {
        });
        fileService.updateFiles(report.getId(), Report.class.getSimpleName(), files, fileData);

        return report;
    }
}