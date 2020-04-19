package com.nicico.sales.model.entities.common;

import com.nicico.sales.model.Auditable;
import com.nicico.sales.model.enumeration.EStatus;
import lombok.Builder;
import lombok.Getter;
import lombok.Setter;
import lombok.experimental.Accessors;

import javax.persistence.Column;
import javax.persistence.MappedSuperclass;
import javax.validation.constraints.NotNull;
import java.util.EnumSet;

@Getter
@Setter
@Accessors(chain = true)
@MappedSuperclass
public class BaseEntity extends Auditable {

    @NotNull
    @Builder.Default
    @Column(name = "B_EDITABLE", nullable = false, columnDefinition = "number default 0")
    private Boolean editable;

    @NotNull
    @Builder.Default
    @Column(name = "N_E_STATUS", nullable = false, columnDefinition = "number default 1")
    @SuppressWarnings("JpaAttributeTypeInspection")
    private EnumSet<EStatus> eStatus;
}
