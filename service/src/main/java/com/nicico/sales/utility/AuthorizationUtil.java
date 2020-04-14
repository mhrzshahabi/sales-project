package com.nicico.sales.utility;

import com.nicico.copper.core.SecurityUtil;
import com.nicico.sales.enumeration.ActionType;
import com.nicico.sales.enumeration.ErrorType;
import com.nicico.sales.exception.SalesException2;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.context.i18n.LocaleContextHolder;
import org.springframework.context.support.ResourceBundleMessageSource;
import org.springframework.stereotype.Component;
import org.springframework.util.StringUtils;

import java.util.Locale;

@Slf4j
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
            throw new SalesException2(ErrorType.Forbidden, "", messageSource.getMessage("exception.action-type.is.empty", null, locale));

        log.debug(messageSource.getMessage("logging.check.authority", null, locale));

        if (!SecurityUtil.hasAuthority(standardPermissionKey))
            throw new SalesException2(ErrorType.UnAuthorized, "", messageSource.getMessage("exception.access-denied", new Object[]{standardPermissionKey}, locale));
    }

    public void checkStandardPermission(String permissionKey) {

        Locale locale = LocaleContextHolder.getLocale();
        log.debug(messageSource.getMessage("logging.check.authority", new Object[]{permissionKey}, locale));
        if (!SecurityUtil.hasAuthority(permissionKey))
            throw new SalesException2(ErrorType.UnAuthorized, "", messageSource.getMessage("exception.access-denied", new Object[]{permissionKey}, locale));
    }
}
