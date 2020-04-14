package com.nicico.sales.listener;

import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.context.ApplicationContext;
import org.springframework.context.event.EventListener;
import org.springframework.context.i18n.LocaleContextHolder;
import org.springframework.context.support.ResourceBundleMessageSource;
import org.springframework.security.access.event.AuthorizationFailureEvent;
import org.springframework.security.authentication.event.AuthenticationFailureBadCredentialsEvent;
import org.springframework.stereotype.Component;
import org.springframework.web.context.request.RequestContextHolder;
import org.springframework.web.context.request.ServletRequestAttributes;
import org.springframework.web.method.HandlerMethod;
import org.springframework.web.servlet.HandlerExecutionChain;
import org.springframework.web.servlet.HandlerMapping;

import javax.servlet.http.HttpServletRequest;
import java.lang.reflect.Method;
import java.util.Locale;

@Slf4j
@Component
@RequiredArgsConstructor
public class FailedAuthRequestAuditor {

    private final ApplicationContext context;
    private ResourceBundleMessageSource messageSource;

    @EventListener
    public void onBadCredentialsEvent(AuthenticationFailureBadCredentialsEvent event) {

        HttpServletRequest request = ((ServletRequestAttributes) RequestContextHolder.getRequestAttributes()).getRequest();
        Method destinationMethod = this.getDestination(request);

        if (destinationMethod != null) {

            Locale locale = LocaleContextHolder.getLocale();
            String message = messageSource.getMessage(
                    "exception.authentication-failed",
                    new Object[]{event.getAuthentication().getName()},
                    locale);
            log.error(message, event.getException());
        }
    }

    @EventListener
    public void onAuthorizationFailureEvent(AuthorizationFailureEvent event) {

        HttpServletRequest request = ((ServletRequestAttributes) RequestContextHolder.getRequestAttributes()).getRequest();
        Method destinationMethod = this.getDestination(request);

        if (destinationMethod != null) {

            Locale locale = LocaleContextHolder.getLocale();
            String message = messageSource.getMessage("exception.access-denied", null, locale);
            log.error(message, event.getAccessDeniedException());
        }
    }

    private Method getDestination(HttpServletRequest request) {

        for (HandlerMapping handlerMapping : context.getBeansOfType(HandlerMapping.class).values()) {

            HandlerExecutionChain handlerExecutionChain = null;
            try {
                handlerExecutionChain = handlerMapping.getHandler(request);
            } catch (Exception e) {
                // do nothing
            }

            if (handlerExecutionChain != null && handlerExecutionChain.getHandler() instanceof HandlerMethod)
                return ((HandlerMethod) handlerExecutionChain.getHandler()).getMethod();
        }

        return null;
    }
}