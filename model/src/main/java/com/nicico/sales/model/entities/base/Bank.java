package com.nicico.sales.model.entities.base;

import com.nicico.sales.model.entities.common.BaseEntity;
import lombok.*;
import lombok.experimental.Accessors;

import javax.persistence.*;

@Getter
@Setter
@NoArgsConstructor
@AllArgsConstructor
@Accessors(chain = true)
@EqualsAndHashCode(of = {"id"}, callSuper = false)
@Entity
@Table(name = "TBL_BANK")
public class Bank extends BaseEntity {

    @Id
    @GeneratedValue(strategy = GenerationType.AUTO, generator = "SEQ_BANK")
    @SequenceGenerator(name = "SEQ_BANK", sequenceName = "SEQ_BANK", allocationSize = 1)
    @Column(name = "ID")
    private Long id;

    @Column(name = "c_NAME_FA", length = 1000)
    private String bankName;

    @Column(name = "c_NAME_EN", length = 1000)
    private String enBankName;

    @Column(name = "c_ADDRESS", length = 1000)
    private String address;

    @Column(name = "c_CORE_BRANCH", length = 100)
    private String coreBranch;

    @Setter(AccessLevel.NONE)
    @ManyToOne(fetch = FetchType.LAZY)
    @JoinColumn(name = "COUNTRY_ID", nullable = false, insertable = false, updatable = false, foreignKey = @ForeignKey(name = "bank2Country"))
    private Country country;

    @Column(name = "COUNTRY_ID")
    private Long countryId;

}
