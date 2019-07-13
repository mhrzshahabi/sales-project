package com.nicico.sales.model.entities.base;

import com.nicico.sales.model.Auditable;
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
@Table(name = "TBL_BANK", schema = "SALES")
public class Bank extends Auditable {

    @Id
    @GeneratedValue(strategy = GenerationType.AUTO, generator = "SEQ_BANK")
    @SequenceGenerator(name = "SEQ_BANK", sequenceName = "SALES.SEQ_BANK")
    @Column(name = "ID", precision = 10)
    private Long id;

    @Column(name = "c_BANK_CODE")
    private String bankCode;

    @Column(name = "c_NAME_FA")
    private String bankName;

    @Column(name = "c_NAME_EN")
    private String enBankName;

    @Column(name = "c_ADDRESS")
    private String address;

    @Column(name = "c_CORE_BRANCH")
    private String coreBranch;

    @Setter(AccessLevel.NONE)
    @ManyToOne(fetch = FetchType.EAGER)
    @JoinColumn(name = "COUNTRY_ID", nullable = false, insertable = false, updatable = false)
    private Country country;

    @Column(name = "COUNTRY_ID")
    private Long countryId;

}
