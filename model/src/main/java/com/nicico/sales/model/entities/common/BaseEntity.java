package com.nicico.sales.model.entities.common;

import com.nicico.sales.model.Auditable;
import com.nicico.sales.model.enumeration.AllConverters;
import com.nicico.sales.model.enumeration.EStatus;
import lombok.Builder;
import lombok.Getter;
import lombok.Setter;
import lombok.experimental.Accessors;

import javax.persistence.*;
import javax.validation.constraints.NotNull;
import java.util.ArrayList;
import java.util.List;

@Getter
@Setter
@Accessors(chain = true)
@MappedSuperclass
public class BaseEntity extends Auditable {

    @NotNull
    @Builder.Default
    @Column(name = "B_EDITABLE", nullable = false, columnDefinition = "number default 1")
    private Boolean editable = true;

    @NotNull
    @Builder.Default
    @ElementCollection(targetClass = EStatus.class)
    @Column(name = "N_E_STATUS", nullable = false, columnDefinition = "number default 1")
    @SuppressWarnings("JpaAttributeTypeInspection")
    private List<EStatus> eStatus = new ArrayList<EStatus>() {{
        add(EStatus.Active);
    }};

    @NotNull
    @Builder.Default
    @Column(name = "N_E_STATUS", nullable = false, insertable = false, updatable = false)
    private Integer eStatusId = 1;

    @PostLoad
    @PrePersist
    public void setEStatusId() {

        this.eStatusId = new AllConverters.EStatusSetConverter().convertToDatabaseColumn(eStatus);
    }
}
