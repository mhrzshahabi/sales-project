package com.nicico.sales.utility;

import lombok.RequiredArgsConstructor;
import org.springframework.expression.EvaluationContext;
import org.springframework.expression.spel.SpelCompilerMode;
import org.springframework.expression.spel.SpelParserConfiguration;
import org.springframework.expression.spel.standard.SpelExpressionParser;
import org.springframework.security.access.expression.ExpressionUtils;
import org.springframework.security.access.expression.method.DefaultMethodSecurityExpressionHandler;
import org.springframework.security.access.expression.method.MethodSecurityExpressionHandler;
import org.springframework.security.core.Authentication;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.security.util.SimpleMethodInvocation;
import org.springframework.stereotype.Component;
import org.springframework.web.context.ContextLoader;
import org.springframework.web.context.WebApplicationContext;

import java.lang.reflect.Method;
import java.util.Objects;

@Component
@RequiredArgsConstructor
public class SecurityChecker {

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
        WebApplicationContext webApplicationContext = Objects.requireNonNull(ContextLoader.getCurrentWebApplicationContext());
        MethodSecurityExpressionHandler expressionHandler = webApplicationContext.getBean(DefaultMethodSecurityExpressionHandler.class);
        SpelParserConfiguration config = new SpelParserConfiguration(SpelCompilerMode.IMMEDIATE, this.getClass().getClassLoader());
        SpelExpressionParser parser = new SpelExpressionParser(config);
        EvaluationContext evaluationContext = expressionHandler.createEvaluationContext(authentication, methodInvocation);
        return ExpressionUtils.evaluateAsBoolean(parser.parseExpression(securityExpression), evaluationContext);
    }
}
