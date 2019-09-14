package com.nicico.sales.model.entities.base.myModel;

import lombok.*;
import lombok.experimental.Accessors;

import javax.persistence.Entity;
import javax.persistence.Id;
import javax.persistence.Table;

@Getter
@Setter
@NoArgsConstructor
@AllArgsConstructor
@Accessors(chain = true)
@EqualsAndHashCode(of = {"id"}, callSuper = false)
@Entity
@Table(name = "TBL_TOZIN_UNIT")
public class Unit {
    @Id
    private  Long ID;
    private String PACKNAME;

    public Long getID() {
        return ID;
    }

    public void setID(Long ID) {
        this.ID = ID;
    }

    public String getPACKNAME() {
        return PACKNAME;
    }

    public void setPACKNAME(String PACKNAME) {
        this.PACKNAME = PACKNAME;
    }
}
