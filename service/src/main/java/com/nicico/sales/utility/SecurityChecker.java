package com.nicico.sales.utility;

import lombok.RequiredArgsConstructor;
import org.springframework.expression.EvaluationContext;
import org.springframework.expression.spel.standard.SpelExpressionParser;
import org.springframework.security.access.expression.ExpressionUtils;
import org.springframework.security.access.expression.method.DefaultMethodSecurityExpressionHandler;
import org.springframework.security.core.Authentication;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.security.util.SimpleMethodInvocation;
import org.springframework.stereotype.Component;

import java.lang.reflect.Method;

@Component
@RequiredArgsConstructor
public class SecurityChecker {

    private final SpelExpressionParser parser;
    private final DefaultMethodSecurityExpressionHandler expressionHandler;

    private static class SecurityObject {
        public void triggerCheck() { /*NOP*/ }
    }

    private static Method triggerCheckMethod;

    static {
        try {
            triggerCheckMethod = SecurityObject.class.getMethod("triggerCheck");
        } catch (NoSuchMethodException ignored) {
        }
    }

    public boolean check(String securityExpression) {

        Authentication authentication = SecurityContextHolder.getContext().getAuthentication();
        SimpleMethodInvocation methodInvocation = new SimpleMethodInvocation(new SecurityObject(), triggerCheckMethod);
        EvaluationContext evaluationContext = expressionHandler.createEvaluationContext(authentication, methodInvocation);
        return ExpressionUtils.evaluateAsBoolean(parser.parseExpression(securityExpression), evaluationContext);
    }
}
