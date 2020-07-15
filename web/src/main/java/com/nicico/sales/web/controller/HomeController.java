package com.nicico.sales.web.controller;

import com.fasterxml.jackson.core.JsonProcessingException;
import com.fasterxml.jackson.databind.ObjectMapper;
import com.nicico.copper.common.domain.ConstantVARs;
import com.nicico.copper.core.SecurityUtil;
import com.nicico.sales.model.enumeration.SymbolUnit;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
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
import java.util.Locale;
import java.util.stream.Collectors;

@Slf4j
@RequiredArgsConstructor
@Controller
@RequestMapping("/")
public class HomeController {

    private final ObjectMapper objectMapper;
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

        return "salesMainDesktop";
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
