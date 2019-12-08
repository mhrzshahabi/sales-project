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
 @Table(name = "TBL_TOZIN_MATERIAL")
public class TMaterial {
    @Id
    private Long ID;
    private Long GDSCODE;
    private String GDSNAME;


/*    @ElementCollection
    @CollectionTable(name="EMP_PLANT")
    @MapKeyEnumerated(EnumType.ORDINAL)
    @MapKeyColumn(name="PlantEnum")
    @Column(name="PLANT_COLL")
    private Map<Long, PlantEnum> plantMaterial = new HashMap();*/








}
