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
@Table(name = "TBL_Move")
public class Movement   {
    @Id
    private Long MATERIAL_ID;
    private String PACKNAME;
    private Long spi;
    private Long tpi;
    private Long GDSCODE;
    private String CONDITION;
    private String TZN_DATE;
    private Long ID;
    private String NAMEFA;
    private String snamefa;
    private String plant;
    @Column(name = "SNAMEEN")
    private String snameen;
    private String GDSNAME;
    private String car;
    private Long wazn;
    private Long tedad;


}
