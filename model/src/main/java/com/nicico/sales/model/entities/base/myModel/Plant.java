package com.nicico.sales.model.entities.base.myModel;

import lombok.*;
import lombok.experimental.Accessors;

import javax.persistence.Column;
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
@Table(name = "TBL_TOZIN_PLANT")
public class Plant {
    @Id
    private  Long ID;
    @Column(name = "NAMEFA")
    private String NAME_FA;
    @Column(name = "NAMEEN")
    private String NAME_EN;


}

