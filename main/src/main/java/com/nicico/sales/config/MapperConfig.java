package com.nicico.sales.config;

import lombok.RequiredArgsConstructor;
import org.modelmapper.ModelMapper;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;
import org.springframework.context.i18n.LocaleContextHolder;

import java.lang.reflect.Field;
import java.util.Arrays;
import java.util.Locale;

@Configuration
@RequiredArgsConstructor
public class MapperConfig {

    private final ModelMapper modelMapper;

    @Bean
    @Qualifier("")
    public ModelMapper getModelMapper() {

        modelMapper.emptyTypeMap(Object.class, Object.class).addMappings(mapper -> mapper.when(mappingContext -> {



        }));
    }
}
/*

package com.nicico.accounting.service.entities.impl.docBuilder.utils;

import com.nicico.accounting.domain.entities.docBuilder.DocumentValueMap;
import com.nicico.accounting.domain.entities.main.DocumentHeader;
import org.modelmapper.Converter;
import org.modelmapper.spi.MappingContext;

import java.lang.reflect.Field;
import java.util.Arrays;
import java.util.LinkedHashMap;
import java.util.List;
import java.util.Map;

public class DocumentHeaderConverter Locale locale = LocaleContextHolder.getLocale();
            String propertyPostfix = locale == Locale.ENGLISH ? "En" : "Fa";
            for (Field destinationField : mappingContext.getDestinationType().getDeclaredFields()) {
                if (Arrays.asList(destinationField.getDeclaredAnnotations()).contains(i18n.class)) {
                    try {

                        Field sourceField = mappingContext.getSourceType().getDeclaredField(destinationField.getName() + propertyPostfix);

                    } catch (NoSuchFieldException e) {
                        // ignore
                    }


                }
            } {

    private static List<Field> documentHeaderFields;

    static {
        documentHeaderFields = Arrays.asList(DocumentHeader.class.getDeclaredFields());
    }

    private final List<DocumentValueMap> maps;
    private final DocumentConverterUtil documentConverterUtil;

    DocumentHeaderConverter(DocumentConverterUtil documentConverterUtil, List<DocumentValueMap> maps) {

        this.maps = maps;
        this.documentConverterUtil = documentConverterUtil;
    }

    public DocumentHeader convert(MappingContext<LinkedHashMap<String, Object>, DocumentHeader> context) {

        Map<String, Object> source = context.getSource();
        if (source == null) return null;

        DocumentHeader destination = new DocumentHeader();
        documentConverterUtil.mapFields(destination, maps, documentHeaderFields, source);
        return destination;
    }
}


 */