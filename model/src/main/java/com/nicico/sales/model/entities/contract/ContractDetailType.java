//package com.nicico.sales.model.entities.contract;
//
//import com.nicico.sales.model.Auditable;
//import com.nicico.sales.model.entities.base.Material;
//import lombok.*;
//import lombok.experimental.Accessors;
//import org.hibernate.annotations.Cascade;
//import org.hibernate.envers.AuditOverride;
//import org.hibernate.envers.Audited;
//import org.hibernate.envers.NotAudited;
//
//import javax.persistence.*;
//
//@Getter
//@Setter
//@NoArgsConstructor
//@AllArgsConstructor
//@Accessors(chain = true)
//@AuditOverride(forClass = Auditable.class)
//@EqualsAndHashCode(of = {"id"}, callSuper = false)
//@Audited
//@Entity
//@Table(name = "TBL_CNTR_CONTRACT")
//public class ContractDetailType extends BaseEntity {
//
//    @NotAudited
//    @OneToOne(mappedBy = "contract", fetch = FetchType.LAZY)
//    @Cascade({org.hibernate.annotations.CascadeType.PERSIST})
//    private ContractDetail contractDetails;
//
//    @Id
//    @GeneratedValue(strategy = GenerationType.AUTO, generator = "SEQ_CNTR_CONTRACT")
//    @SequenceGenerator(name = "SEQ_CNTR_CONTRACT", sequenceName = "SEQ_CNTR_CONTRACT", allocationSize = 1)
//    @Column(name = "ID")
//    private Long id;
//
//    @Column(name = "C_CONTRACT_NO", nullable = false, length = 200)
//    private String contractNo;
//
//    @Column(name = "C_CONTRACT_DATE", length = 50)
//    private String contractDate;
//
//    @Column(name = "C_IS_COMPLETE", length = 3)
//    private String isComplete;
//
//    @Column(name = "C_DESCL", length = 4000)
//    private String descl;
//
//    @Setter(AccessLevel.NONE)
//    @ManyToOne(fetch = FetchType.LAZY)
//    @NotAudited
//    @JoinColumn(name = "MATERIAL_ID", insertable = false, updatable = false, foreignKey = @ForeignKey(name = "contract2materialByMaterialId"))
//    private Material material;
//
//    @Column(name = "MATERIAL_ID", nullable = false)
//    private Long materialId;
//}
//
//
