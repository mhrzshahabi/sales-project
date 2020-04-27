package com.nicico.sales.utility;

import com.nicico.copper.core.SecurityUtil;
import com.nicico.sales.enumeration.ActionType;
import com.nicico.sales.exception.UnAuthorizedException;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.context.i18n.LocaleContextHolder;
import org.springframework.context.support.ResourceBundleMessageSource;
import org.springframework.stereotype.Component;

import java.util.Locale;

@Slf4j
@Component
@RequiredArgsConstructor
public class AuthorizationUtil {

    private final SecurityChecker securityChecker;
    private final ResourceBundleMessageSource messageSource;

    public String getStandardPermissionKey(String entityName, String actionTypeStr) {

        entityName = entityName.toUpperCase();
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
        log.debug(messageSource.getMessage("logging.check.authority", null, locale));
        if (!SecurityUtil.hasAuthority(standardPermissionKey))
            throw new UnAuthorizedException(standardPermissionKey);
    }

    public void checkStandardPermission(String permissionKey) {

        Locale locale = LocaleContextHolder.getLocale();
        log.debug(messageSource.getMessage("logging.check.authority", new Object[]{permissionKey}, locale));
        if (!evaluatePermissionKey(permissionKey))
            throw new UnAuthorizedException(permissionKey);
    }

    private Boolean evaluatePermissionKey(String permissionKey) {

        if (permissionKey == null) return false;
        if (permissionKey.matches("^[a-zA-Z0-9_]+$")) SecurityUtil.hasAuthority(permissionKey);

        return securityChecker.check(permissionKey);
    }
}
