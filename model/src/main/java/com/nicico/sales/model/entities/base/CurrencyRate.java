package com.nicico.sales.model.entities.base;

import com.nicico.sales.model.entities.common.BaseEntity;
import com.nicico.sales.model.enumeration.RateReference;
import com.nicico.sales.model.enumeration.SymbolCurrency;
import lombok.*;
import lombok.experimental.Accessors;

import javax.persistence.*;
import javax.validation.constraints.NotNull;
import java.util.Date;

@Getter
@Setter
@NoArgsConstructor
@AllArgsConstructor
@Accessors(chain = true)
@EqualsAndHashCode(of = {"id"}, callSuper = false)
@Entity
@Table(name = "TBL_CURRENCY_RATE",

        uniqueConstraints = {
                @UniqueConstraint(columnNames = {"D_CURRENCY_DATE", "N_FROM", "N_TO", "N_REFERENCE"}, name = CurrencyRate.UNIQUE_LIST_CURRENCY_RATE)

        })
public class CurrencyRate extends BaseEntity {

    public static final String UNIQUE_LIST_CURRENCY_RATE = "UNIQE_List_CrrencyRate";

    @Id
    @GeneratedValue(strategy = GenerationType.AUTO, generator = "SEQ_CURRENCY_RATE")
    @SequenceGenerator(name = "SEQ_CURRENCY_RATE", sequenceName = "SEQ_CURRENCY_RATE", allocationSize = 1)
    @Column(name = "ID")
    private Long id;

    @NotNull
    @Column(name = "D_CURRENCY_DATE"  , nullable = false)
    private Date currencyDate;

    @NotNull
    @Column(name = "N_FROM", nullable = false)
    private SymbolCurrency symbolCurrencyFrom;

    @NotNull
    @Column(name = "N_TO", nullable = false)
    private SymbolCurrency symbolCurrencyTo;

    @NotNull
    @Column(name = "N_REFERENCE", nullable = false)
    private RateReference reference;

}
