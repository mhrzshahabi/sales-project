package com.nicico.sales.utility;

import com.nicico.copper.core.SecurityUtil;
import com.nicico.sales.model.entities.common.BaseEntity;
import org.springframework.expression.EvaluationContext;
import org.springframework.expression.spel.standard.SpelExpressionParser;
import org.springframework.security.access.expression.ExpressionUtils;
import org.springframework.security.core.Authentication;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.security.oauth2.provider.expression.OAuth2MethodSecurityExpressionHandler;
import org.springframework.security.util.SimpleMethodInvocation;
import org.springframework.stereotype.Component;

import javax.servlet.http.HttpServletRequest;
import java.util.Arrays;
import java.util.List;
import java.util.Optional;

@Component
public class SecurityChecker {

    private static final SpelExpressionParser parser;

    static {
        parser = new SpelExpressionParser();
    }

    public static boolean check(String securityExpression) {

        Authentication authentication = SecurityContextHolder.getContext().getAuthentication();
        OAuth2MethodSecurityExpressionHandler expressionHandler = new OAuth2MethodSecurityExpressionHandler();
        EvaluationContext evaluationContext = expressionHandler.createEvaluationContext(authentication, new SimpleMethodInvocation());
        return ExpressionUtils.evaluateAsBoolean(parser.parseExpression(securityExpression), evaluationContext);
    }

    public static void addEntityPermissionToRequest(HttpServletRequest request, Class<? extends BaseEntity>... classes) {
        List<String> eight = Arrays.asList("R", "C", "U", "D", "F", "O", "A", "I");
        for (String p : eight) {
            Boolean hasPermission = Arrays.stream(classes).map(clazz -> {
                String entityName = StringFormatUtil.makeMessageKey(clazz.getSimpleName(), "_").toUpperCase();
                return Optional.of(SecurityUtil.hasAuthority(p + "_" + entityName)).orElse(false);
            }).reduce((a, b) -> a && b).get();
            request.setAttribute(p.toLowerCase() + "_entity", hasPermission);
        }
    }

    public static void addViewPermissionToRequest(HttpServletRequest request, Class clazz) {
        String entityName = StringFormatUtil.makeMessageKey(clazz.getSimpleName(), "_").toUpperCase();
        Boolean hasPermission = Optional.of(SecurityUtil.hasAuthority("R_" + entityName)).orElse(false);
        request.setAttribute("r_entity", hasPermission);
    }

}