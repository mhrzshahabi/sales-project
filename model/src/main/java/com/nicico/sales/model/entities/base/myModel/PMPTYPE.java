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
@Table(name = "TBL_Interpreter")
@Entity
public class PMPTYPE {
    @Id
    private Long p_id;
    private Long GDSCODE;
    private Long PACK_TYPE;
    private Long PLANT_ID;
    private String GDSNAME;
    private String NAMEFA;
    private String NAMEEN;
    private String PACKNAME;
}
