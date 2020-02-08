package com.nicico.sales.utility;

import com.fasterxml.jackson.databind.ObjectMapper;
import com.nicico.copper.common.domain.criteria.NICICOCriteria;
import com.nicico.copper.common.dto.search.SearchDTO;
import lombok.RequiredArgsConstructor;
import org.apache.commons.lang3.StringUtils;
import org.springframework.stereotype.Component;
import org.springframework.util.MultiValueMap;

import java.io.IOException;
import java.lang.reflect.Field;
import java.util.*;
import java.util.concurrent.ConcurrentHashMap;
import java.util.function.Function;
import java.util.function.Predicate;
import java.util.regex.Pattern;
import java.util.stream.Collectors;

@Component
@RequiredArgsConstructor
public class SpecListUtil {

    private final ObjectMapper objectMapper;

    public <P extends SearchDTO.SearchRq, Q> Q createSearchRq(Integer startRow, Integer endRow, String operator, String criteria, String sortBy, Function<P, Q> work) throws IOException {

        SearchDTO.SearchRq request = new SearchDTO.SearchRq();
        request.setStartIndex(startRow).setCount(endRow - startRow);

        if (StringUtils.isNotEmpty(criteria)) {

            if (StringUtils.isNotEmpty(operator))
                criteria = String.format("{\"operator\":\"%s\", \"criteria\":[%s]}", operator, criteria);

            SearchDTO.CriteriaRq criteriaRq = objectMapper.readValue(criteria, SearchDTO.CriteriaRq.class);
            if (criteriaRq != null)
                criteriaRq.setCriteria(criteriaRq.getCriteria().stream().filter(distinct(SearchDTO.CriteriaRq::toString)).collect(Collectors.toList()));
            request.setCriteria(criteriaRq);
        }
        if (StringUtils.isNotEmpty(sortBy)) {
            request.setSortBy(sortBy);
        }

        return work.apply((P) request);
    }

    public <K> Map<String, Object> getCoveredByResponse(List<K> data) {

        Map<String, Object> dataMap = new HashMap<String, Object>() {{
            put("data", data);
            put("startRow", 0);
            put("endRow", data.size());
            put("totalRows", data.size());
        }};

        return new HashMap<String, Object>() {{
            put("response", dataMap);
        }};
    }

    public NICICOCriteria provideNICICOCriteria(MultiValueMap<String, String> criteria, Class<?> clazz) {

        if (criteria == null || criteria.size() == 0) return null;

        if (criteria.get("criteria") == null)
            criteria.add("criteria", null);

        List<String> criteriaEntry = criteria.get("criteria");
        criteria.forEach((q, i) -> {

            if (q.equals("criteria") || q.matches(".+[.]operator]")) return;

            String fieldName = new ArrayList<>(Arrays.asList(q.split(Pattern.quote(".")))).get(0);
            try {

                getField(fieldName, clazz);

            } catch (Exception e) {

                e.printStackTrace();
                return;
            }

            List<String> values = criteria.get(q);
            List<String> operators = criteria.get(q + ".operator");
            if (values.size() > 1) {

                if (operators != null && operators.size() == 1)
                    criteriaEntry.add(String.format("{\"fieldName\":\"%s\",\"operator\":\"%s\",\"value\":%s}", q, operators.get(0), values));
                else
                    criteriaEntry.add(String.format("{\"fieldName\":\"%s\",\"operator\":\"iContains\",\"value\":%s}", q, values));
            } else if (operators != null && operators.size() == 1)
                criteriaEntry.add(String.format("{\"fieldName\":\"%s\",\"operator\":\"%s\",\"value\":\"%s\"}", q, operators.get(0), values.get(0)));
            else if (values.size() == 0 || values.get(0) == null)
                criteriaEntry.add(String.format("{\"fieldName\":\"%s\",\"operator\":\"isNull\"}", q));
            else if (values.get(0).matches("\\d+"))
                criteriaEntry.add(String.format("{\"fieldName\":\"%s\",\"operator\":\"equals\",\"value\":%s}", q, values.get(0)));
            else
                criteriaEntry.add(String.format("{\"fieldName\":\"%s\",\"operator\":\"iContains\",\"value\":\"%s\"}", q, values.get(0)));
        });

        if (criteriaEntry != null) {

            criteriaEntry.removeIf(q -> q == null || q.equals("") || q.equals("{}"));
            if (criteriaEntry.size() == 0)
                criteria.remove("criteria");
        }

        NICICOCriteria nCriteria = NICICOCriteria.of(criteria);
        if (nCriteria.getOperator() == null) nCriteria.setOperator("and");

        return nCriteria;
    }

    public static <T> Predicate<T> distinct(Function<? super T, ?> keyExtractor) {

        Set<Object> seen = ConcurrentHashMap.newKeySet();
        return t -> seen.add(keyExtractor.apply(t));
    }

    private Field getField(String fieldName, Class<?> entityClass) {

        try {

            return entityClass.getDeclaredField(fieldName);
        } catch (NoSuchFieldException e) {

            return getField(fieldName, entityClass.getSuperclass());
        }
    }
}
