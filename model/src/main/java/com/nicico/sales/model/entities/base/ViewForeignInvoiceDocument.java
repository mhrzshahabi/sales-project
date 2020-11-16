package com.nicico.sales.model.entities.base;

import com.nicico.sales.model.enumeration.CategoryUnit;
import com.nicico.sales.model.enumeration.CurrencyType;
import com.nicico.sales.model.enumeration.RateReference;
import com.nicico.sales.model.enumeration.SymbolUnit;
import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;
import lombok.experimental.Accessors;
import org.hibernate.annotations.Immutable;
import org.hibernate.annotations.Subselect;

import javax.persistence.Column;
import javax.persistence.Embeddable;
import javax.persistence.EmbeddedId;
import javax.persistence.Entity;
import java.io.Serializable;
import java.math.BigDecimal;
import java.util.Date;
import java.util.Objects;

@Getter
@NoArgsConstructor
@AllArgsConstructor
@Entity
@Immutable
@Subselect("SELECT * FROM VIEW_FOREIGN_INVOICE_DOCUMENT")
public class ViewForeignInvoiceDocument {

	@EmbeddedId
	private ForeignInvoiceId id;

	@Column(name = "FI_C_CONVERSION_SUM_PRICE_TEXT")
	private String fiConversionSumPriceText;

	@Column(name = "FI_C_DESCRIPTION")
	private String fiDescription;

	@Column(name = "FI_C_NO", nullable = false)
	private String fiNo;

	@Column(name = "FI_D_CONVERSION_DATE")
	private Date fiConversionDate;

	@Column(name = "FI_D_DATE", nullable = false)
	private Date fiDate;

	@Column(name = "FI_N_CONVERSION_RATE")
	private BigDecimal fiConversionRate;

	@Column(name = "FI_N_CONVERSION_SUM_PRICE")
	private BigDecimal fiConversionSumPrice;

	@Column(name = "FI_N_PERCENT")
	private Double fiPercent;

	@Column(name = "FI_N_SUM_FI_PRICE", nullable = false)
	private BigDecimal fiSumFIPrice;

	@Column(name = "FI_N_SUM_PI_PRICE", nullable = false)
	private BigDecimal fiSumPIPrice;

	@Column(name = "FI_N_SUM_PRICE", nullable = false)
	private BigDecimal fiSumPrice;

	@Column(name = "FI_N_UNIT_COST", nullable = false)
	private BigDecimal fiUnitCost;

	@Column(name = "FI_N_UNIT_PRICE", nullable = false)
	private BigDecimal fiUnitPrice;

	@Column(name = "FII_N_TC")
	private BigDecimal fiiTreatCost;

	@Column(name = "FII_N_WEIGHT_GW", nullable = false)
	private BigDecimal fiiWeightGW;

	@Column(name = "FII_N_WEIGHT_ND", nullable = false)
	private BigDecimal fiiWeightND;

	@Column(name = "WRD_ID", nullable = false)
	private Long wrdId;

	@Column(name = "WRD_N_AMOUNT", nullable = false)
	private Long wrdAmount;

	@Column(name = "WRD_N_WEIGHT")
	private Long wrdWeight;

	@Column(name = "WI_ID", nullable = false)
	private Long wiId;

	@Column(name = "WI_C_LABEL", nullable = false)
	private String wiLabel;

	@Column(name = "CR_ID", nullable = false)
	private Long crId;

	@Column(name = "CR_D_CURRENCY_DATE", nullable = false)
	private Date crCurrencyDate;

	@Column(name = "CR_N_CURRENCY_RATE_VALUE", nullable = false, scale = 2, precision = 10)
	private BigDecimal crCurrencyRateValue;

	@Column(name = "CR_N_CURRENCY_TYPE_FROM")
	private CurrencyType crCurrencyTypeFrom;

	@Column(name = "CR_N_CURRENCY_TYPE_TO")
	private CurrencyType crCurrencyTypeTo;

	@Column(name = "CR_N_REFERENCE", nullable = false)
	private RateReference crReference;

	@Column(name = "U_ID", nullable = false)
	private Long uId;

	@Column(name = "U_C_NAME_EN", nullable = false)
	private String uNameEN;

	@Column(name = "U_C_NAME_FA", nullable = false)
	private String uNameFA;

	@Column(name = "U_N_CATEGORY_UNIT")
	private CategoryUnit uCategoryUnit;

	@Column(name = "U_N_SYMBOL_UNIT")
	private SymbolUnit uSymbolUnit;

	@Column(name = "BC_ID", nullable = false)
	private Long bcId;

	@Column(name = "BC_C_COMMERCIAL_REGISTRATION")
	private String bcCommercialRegistration;

	@Column(name = "BC_C_COMMERCIAL_ROLE")
	private String bcCommercialRole;

	@Column(name = "BC_C_ECONOMICAL_CODE")
	private String bcEconomicalCode;

	@Column(name = "BC_C_FULLNAME_EN", length = 1000)
	private String bcNameEN;

	@Column(name = "BC_C_FULLNAME_FA", nullable = false, length = 1000)
	private String bcNameFA;

	@Column(name = "BC_C_NATIONAL_CODE")
	private String bcNationalCode;

	@Column(name = "BC_C_REGISTER_NUMBER")
	private String bcRegisterNumber;

	@Column(name = "BC_C_TRADE_MARK")
	private String bcTradeMark;

	@Column(name = "BC_C_TYPE")
	private Boolean bcType;

	@Column(name = "IT_ID", nullable = false)
	private Long itId;

	@Column(name = "IT_TITLE", nullable = false, length = 80)
	private String itTitle;

	@Column(name = "C_ID", nullable = false)
	private Long cId;

	@Column(name = "C_C_NO", nullable = false)
	private String cNo;

	@Getter
	@Setter
	@Accessors(chain = true)
	@Embeddable
	public static class ForeignInvoiceId implements Serializable {

		@Column(name = "FI_ID", nullable = false)
		private Long fiId;

		@Column(name = "FII_ID", nullable = false)
		private Long fiiId;

		@Override
		public boolean equals(Object o) {
			if (this == o) return true;
			if (!(o instanceof ViewForeignInvoiceDocument.ForeignInvoiceId)) return false;
			ViewForeignInvoiceDocument.ForeignInvoiceId that = (ViewForeignInvoiceDocument.ForeignInvoiceId) o;
			return Objects.equals(getFiId(), that.getFiId()) &&
					Objects.equals(getFiiId(), that.getFiiId());
		}

		@Override
		public int hashCode() {
			return Objects.hash(getFiId(), getFiiId());
		}
	}
}
