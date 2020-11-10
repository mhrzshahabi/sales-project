package com.nicico.sales.annotation.report;

import java.lang.annotation.ElementType;
import java.lang.annotation.Retention;
import java.lang.annotation.RetentionPolicy;
import java.lang.annotation.Target;

@Target(ElementType.FIELD)
@Retention(RetentionPolicy.RUNTIME)
public @interface ReportField {

    String titleMessageKey();

    boolean hidden() default false;

    boolean canFilter() default true;
}
