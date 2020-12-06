package com.nicico.sales.web.controller;

import com.fasterxml.jackson.core.JsonProcessingException;
import com.fasterxml.jackson.databind.ObjectMapper;
import com.nicico.copper.common.domain.ConstantVARs;
import com.nicico.copper.core.SecurityUtil;
import com.nicico.copper.core.service.minio.EFileAccessLevel;
import com.nicico.sales.enumeration.ErrorType;
import com.nicico.sales.exception.SalesException2;
import com.nicico.sales.model.enumeration.EFileStatus;
import com.nicico.sales.model.enumeration.EStatus;
import com.nicico.sales.model.enumeration.SymbolUnit;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.context.i18n.LocaleContextHolder;
import org.springframework.context.support.ResourceBundleMessageSource;
import org.springframework.security.authentication.AnonymousAuthenticationToken;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.LocaleResolver;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.util.Arrays;
import java.util.HashMap;
import java.util.Locale;
import java.util.Map;
import java.util.stream.Collectors;

@Slf4j
@RequiredArgsConstructor
@Controller
@RequestMapping("/")
public class HomeController {

    private final ObjectMapper objectMapper;
    private final ResourceBundleMessageSource messageSource;
    private final LocaleResolver localeResolver;

    @GetMapping(value = {"/", "/home"})
    public String showHomePage(HttpServletRequest request, HttpServletResponse response) throws JsonProcessingException {

        request.getSession().setAttribute("userFullName", SecurityUtil.getFullName());
        localeResolver.setLocale(request, response, new Locale(request.getParameter("lang") == null ? ConstantVARs.LANGUAGE_FA : request.getParameter("lang")));

        request.setAttribute("Enum_SymbolUnit", objectMapper.writeValueAsString(
                Arrays.stream(SymbolUnit.values()).collect(Collectors.toMap(SymbolUnit::name, SymbolUnit::name)))
        );

        request.setAttribute("Enum_SymbolUnit_WithValue", objectMapper.writeValueAsString(
                Arrays.stream(SymbolUnit.values()).collect(Collectors.toMap(SymbolUnit::name, SymbolUnit::getId)))
        );

        request.setAttribute("Enum_EStatus", objectMapper.writeValueAsString(
                Arrays.stream(EStatus.values()).collect(Collectors.toMap(EStatus::name, EStatus::name)))
        );

        request.setAttribute("Enum_EStatus_WithId", objectMapper.writeValueAsString(
                Arrays.stream(EStatus.values()).collect(Collectors.toMap(EStatus::name, EStatus::getId)))
        );

        Map<String, String> accessLevel = getAccessLevelEnumMap();
        request.setAttribute("Enum_EFileAccessLevel", objectMapper.writeValueAsString(accessLevel));

        Map<String, String> fileStatus = getFileStatusEnumMap();
        request.setAttribute("Enum_FileStatus", objectMapper.writeValueAsString(fileStatus));

        return "salesMainDesktop";
    }

    private Map<String, String> getFileStatusEnumMap() {

        Map<String, String> fileStatus = new HashMap<>();
        Locale locale = LocaleContextHolder.getLocale();
        for (EFileStatus value : EFileStatus.values())
            if (value == EFileStatus.NORMAL)
                fileStatus.put(value.name(), messageSource.getMessage("file.status.normal", null, locale));
            else if (value == EFileStatus.DELETED)
                fileStatus.put(value.name(), messageSource.getMessage("file.status.deleted", null, locale));

            else throw new SalesException2(ErrorType.InvalidData, null, "روالی برای نگاشت وضعیت فایل تعریف نشده است");

        return fileStatus;
    }

    private Map<String, String> getAccessLevelEnumMap() {

        Map<String, String> accessLevel = new HashMap<>();
        Locale locale = LocaleContextHolder.getLocale();
        for (EFileAccessLevel value : EFileAccessLevel.values())
            if (value == EFileAccessLevel.SELF)
                accessLevel.put(value.name(), messageSource.getMessage("file.access-level.self", null, locale));
            else if (value == EFileAccessLevel.PUBLIC)
                accessLevel.put(value.name(), messageSource.getMessage("file.access-level.public", null, locale));

            else
                throw new SalesException2(ErrorType.InvalidData, null, "روالی برای نگاشت نوع دسترسی به فایل تعریف نشده است");

        return accessLevel;
    }

    @GetMapping("/oauth_login")
    public String getLoginPage(Model model) {
        if (!(SecurityContextHolder.getContext().getAuthentication() instanceof AnonymousAuthenticationToken) && SecurityContextHolder.getContext().getAuthentication().isAuthenticated()) {
            return "redirect:/";
        } else {
            return "redirect:/oauth2/authorization/sso-login";
        }
    }
}
