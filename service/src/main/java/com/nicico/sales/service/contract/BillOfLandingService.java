package com.nicico.sales.service.contract;


import com.nicico.sales.dto.contract.BillOfLandingDTO;
import com.nicico.sales.enumeration.ActionType;
import com.nicico.sales.enumeration.ErrorType;
import com.nicico.sales.exception.SalesException2;
import com.nicico.sales.iservice.contract.IBillOfLandingService;
import com.nicico.sales.model.entities.common.BaseEntity;
import com.nicico.sales.model.entities.contract.BillOfLanding;
import com.nicico.sales.service.GenericService;
import com.nicico.sales.utility.EntityRelationChecker;
import com.nicico.sales.utility.StringFormatUtil;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.i18n.LocaleContextHolder;
import org.springframework.context.support.ResourceBundleMessageSource;
import org.springframework.stereotype.Service;

import java.util.List;
import java.util.Locale;
import java.util.Map;
import java.util.stream.Collectors;

@Slf4j
@RequiredArgsConstructor
@Service
public class BillOfLandingService extends GenericService<BillOfLanding, Long,
        BillOfLandingDTO.Create, BillOfLandingDTO.Info, BillOfLandingDTO.Update, BillOfLandingDTO.Delete> implements IBillOfLandingService {

    @Autowired
    private EntityRelationChecker relationChecker;

    private final ResourceBundleMessageSource messageSource;

    @Override
    public Boolean validation(BillOfLanding entity, Object... request) {
        boolean needToCheckRelations = actionType.equals(ActionType.Update) ||
                actionType.equals(ActionType.UpdateAll) ||
                actionType.equals(ActionType.Delete) ||
                actionType.equals(ActionType.DeleteAll);

        if (needToCheckRelations) {
            Map<Class<? extends BaseEntity>, List<BaseEntity>> relations = relationChecker.getRecordRelations(BillOfLanding.class, entity.getId());
            if (!relations.isEmpty()) {
                Locale locale = LocaleContextHolder.getLocale();
                String message;
                List<String> collect = relations.keySet().stream()
                        .map(Class::getSimpleName)
                        .map(s -> messageSource.getMessage("entity." + StringFormatUtil.makeMessageKey(s, "-"), null, locale))
                        .collect(Collectors.toList());
                message = messageSource.getMessage("global.grid.record.is.used.warn", new Object[]{collect}, locale);
                throw new SalesException2(ErrorType.Unknown, "", messageSource.getMessage(message, null, locale));
            }
        }
        return super.validation(entity, request);
    }


}
