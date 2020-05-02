package com.nicico.sales.model.annotation;

import com.nicico.sales.model.enumeration.ConstraintType;

import java.lang.annotation.ElementType;
import java.lang.annotation.Retention;
import java.lang.annotation.RetentionPolicy;
import java.lang.annotation.Target;

@Target({ElementType.TYPE})
@Retention(RetentionPolicy.RUNTIME)
public @interface EntityConstraint {

    String constraintName();

    String[] constraintFields();

    ConstraintType constraintType();
}