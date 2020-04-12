package com.nicico.sales.utility;

import com.nicico.copper.core.SecurityUtil;
import com.nicico.sales.EvaluationException;
import com.nicico.sales.SalesException;
import com.nicico.sales.enumeration.ActionType;
import lombok.RequiredArgsConstructor;
import org.springframework.context.i18n.LocaleContextHolder;
import org.springframework.context.support.ResourceBundleMessageSource;
import org.springframework.stereotype.Component;
import org.springframework.util.StringUtils;

import java.util.Locale;

@Component
@RequiredArgsConstructor
public class AuthorizationUtil {

    private final ResourceBundleMessageSource messageSource;

    public String getStandardPermissionKey(String entityName, String actionTypeStr) {

        ActionType actionType = ActionType.valueOf(actionTypeStr);
        switch (actionType) {

            case Get:
            case List:
            case Search:
                return "R_" + entityName;
            case Create:
            case CreateAll:
                return "C_" + entityName;
            case Update:
            case UpdateAll:
                return "U_" + entityName;
            case Delete:
            case DeleteAll:
                return "D_" + entityName;
            default:
                return null;
        }
    }

    public void checkStandardPermission(String entityName, String actionTypeStr) {

        Locale locale = LocaleContextHolder.getLocale();
        String standardPermissionKey = getStandardPermissionKey(entityName, actionTypeStr);
        if (StringUtils.isEmpty(standardPermissionKey))
            throw new EvaluationException(EvaluationException.ErrorType.Forbidden, "", messageSource.getMessage("validator.permission.action-type.is.empty", null, locale));
        if (!SecurityUtil.hasAuthority(standardPermissionKey))
            throw new EvaluationException(EvaluationException.ErrorType.Unauthorized, "", messageSource.getMessage("validator.permission.access-denied", new Object[]{standardPermissionKey}, locale));
    }
    public void checkStandardPermission(String permissionKey) {

        Locale locale = LocaleContextHolder.getLocale();
        if (!SecurityUtil.hasAuthority(permissionKey))
            throw new EvaluationException(EvaluationException.ErrorType.Unauthorized, "", messageSource.getMessage("validator.permission.access-denied", new Object[]{permissionKey}, locale));
    }
}
