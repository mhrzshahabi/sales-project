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
@Table(name = "TBL_LME")
public class LME extends Auditable {

    @Id
    @GeneratedValue(strategy = GenerationType.SEQUENCE, generator = "LME_SEQ")
    @SequenceGenerator(name = "LME_SEQ", sequenceName = "SEQ_LME_ID",allocationSize = 1)
    @Column(name = "ID", precision = 10)
    private Long id;

    @Column(name = "LME_DATE")
    private String lmeDate;

    @Column(name = "CU_USD_MT")
    private String cuUsdMt;

    @Column(name = "GOLD_USD_OUNCE")
    private String goldUsdOunce;

    @Column(name = "SILVER_USD_OUNCE")
    private String silverUsdOunce;

    @Column(name = "SELENIUM_USD_IB")
    private String seleniumUsdLb;

    @Column(name = "PLATINUM_USD_OUNCE")
    private String platinumUsdOunce;

    @Column(name = "PALLADIUM_USD_OUNCE")
    private String palladiumUsdOunce;

    @Column(name = "MOLYBDENUM_USD_LB")
    private String molybdenumUsdLb;
}
