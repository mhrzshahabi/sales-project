//package com.nicico.sales.utility;
//
//import com.nicico.copper.common.domain.ConstantVARs;
//import lombok.RequiredArgsConstructor;
//import org.springframework.beans.factory.annotation.Value;
//import org.springframework.http.HttpEntity;
//import org.springframework.http.HttpMethod;
//import org.springframework.stereotype.Component;
//import org.springframework.util.LinkedMultiValueMap;
//import org.springframework.util.MultiValueMap;
//import org.springframework.util.StringUtils;
//import org.springframework.web.client.RestTemplate;
//import org.springframework.web.util.UriComponentsBuilder;
//
//import javax.servlet.http.HttpServletRequest;
//import java.io.UnsupportedEncodingException;
//import java.net.URLDecoder;
//import java.util.Enumeration;
//
//@Component
//@RequiredArgsConstructor
//public class MakeRestRequestUtil {
//
//    @Value("${nicico.rest-api.url}")
//    private String restApiUrl;
//
//    public <K, V> K makeRequest(HttpServletRequest request, Class<K> resultClass, String restApiRelativeUrl) throws UnsupportedEncodingException {
//
//        return makeRequest(request, resultClass, restApiRelativeUrl, HttpMethod.GET, null, null);
//    }
//
//    @SuppressWarnings("unchecked")
//    public <K, V> K makeRequest(HttpServletRequest request, Class<K> resultClass, String restApiRelativeUrl, HttpMethod method, MultiValueMap<String, String> headers, V body) throws UnsupportedEncodingException {
//
//        if (headers == null) {
//
//            headers = new LinkedMultiValueMap<>();
//
//            Enumeration<String> headerNames = request.getHeaderNames();
//            while (headerNames.hasMoreElements()) {
//
//                String headerName = headerNames.nextElement();
//                headers.add(headerName, request.getHeader(headerName));
//            }
//        }
//        if (headers.get("authorization") == null)
//            headers.add("authorization", "Bearer " + request.getSession().getAttribute(ConstantVARs.ACCESS_TOKEN));
//
//        MultiValueMap<String, String> params = new LinkedMultiValueMap();
//        Enumeration<String> parameterNames = request.getParameterNames();
//        while (parameterNames.hasMoreElements()) {
//
//            String parameter = parameterNames.nextElement();
//            String parameterValue = request.getParameter(parameter);
//            if (StringUtils.isEmpty(parameterValue) || parameterValue.equals("{}")) continue;
//
//            params.set(parameter, parameterValue);
//        }
//
//        RestTemplate restTemplate = new RestTemplate();
//        HttpEntity<V> httpEntity = new HttpEntity<>(body, headers);
//        UriComponentsBuilder builder = UriComponentsBuilder.fromUriString(restApiUrl + restApiRelativeUrl).queryParams(params);
//        return restTemplate.exchange(builder.build().toUri(), method, httpEntity, resultClass).getBody();
//    }
//}