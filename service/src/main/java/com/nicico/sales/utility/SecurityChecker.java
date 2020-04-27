package com.nicico.sales.utility;

import org.springframework.expression.EvaluationContext;
import org.springframework.expression.spel.standard.SpelExpressionParser;
import org.springframework.security.access.expression.ExpressionUtils;
import org.springframework.security.core.Authentication;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.security.oauth2.provider.expression.OAuth2MethodSecurityExpressionHandler;
import org.springframework.security.util.SimpleMethodInvocation;
import org.springframework.stereotype.Component;

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
}
