package com.nicico.sales.web.controller;

import com.nicico.copper.core.SecurityUtil;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.security.authentication.AnonymousAuthenticationToken;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.security.oauth2.client.OAuth2AuthorizedClientService;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;

import javax.servlet.http.HttpSession;

@Slf4j
@RequiredArgsConstructor
@Controller
@RequestMapping("/")
public class HomeController {

    private final OAuth2AuthorizedClientService authorizedClientService;

//    @Value("${nicico.oauth2.server.url}")
//    private String oauth2ServerUrl;

    @GetMapping(value = {"/", "/home"})
    public String showHomePage(HttpSession session) {
    	session.setAttribute("userFullName", SecurityUtil.getFullName());

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

//    @GetMapping("/oauth_logout")
//    public String logout() {
//        return "redirect:" + oauth2ServerUrl;
//    }
}
