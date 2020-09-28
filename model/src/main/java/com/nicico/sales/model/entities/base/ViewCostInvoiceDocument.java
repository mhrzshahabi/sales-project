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
@Subselect("SELECT * FROM VIEW_COST_INVOICE_DOCUMENT")
public class ViewCostInvoiceDocument {

	@EmbeddedId
	private CostInvoiceId id;

	@Column(name = "SHCI_F_BUYER_CONTACT_ID", nullable = false)
	private Long shciBuyerContactId;

	@Column(name = "SHCI_N_BUYER_SHARE", nullable = false)
	private Double shciBuyerShare;

	@Column(name = "SHCI_N_C_VAT", nullable = false, scale = 5, precision = 10)
	private BigDecimal shciCVat;

	@Column(name = "SHCI_D_CONVERSION_DATE")
	private Date shciConversionDate;

	@Column(name = "SHCI_N_CONVERSION_RATE", nullable = false, scale = 5, precision = 10)
	private BigDecimal shciConversionRate;

	@Column(name = "SHCI_F_CONVERSION_REF_ID")
	private Long shciConversionRefId;

	@Column(name = "SHCI_N_CONVERSION_SUM_PRICE", nullable = false, scale = 6, precision = 18)
	private BigDecimal shciConversionSumPrice;

	@Column(name = "SHCI_N_CONVERSION_SUM_PRICE_BUYER_SHARE", nullable = false, scale = 6, precision = 18)
	private BigDecimal shciConversionSumPriceBuyerShare;

	@Column(name = "SHCI_N_CONVERSION_SUM_PRICE_SELLER_SHARE", nullable = false, scale = 6, precision = 18)
	private BigDecimal shciConversionSumPriceSellerShare;

	@Column(name = "SHCI_C_CONVERSION_SUM_PRICE_TEXT", nullable = false)
	private String shciConversionSumPriceText;

	@Column(name = "SHCI_C_DESCRIPTION", length = 4000)
	private String shciDescription;

	@Column(name = "SHCI_F_FINANCE_UNIT_ID", nullable = false)
	private Long shciFinanceUnitId;

	@Column(name = "SHCI_D_INVOICE_DATE", nullable = false)
	private Date shciInvoiceDate;

	@Column(name = "SHCI_C_INVOICE_NO")
	private String shciInvoiceNo;

	@Column(name = "SHCI_C_INVOICE_NO_PAPER", nullable = false)
	private String shciInvoiceNoPaper;

	@Column(name = "SHCI_F_INVOICE_TYPE_ID", nullable = false)
	private Long shciInvoiceTypeId;

	@Column(name = "SHCI_N_REFERENCE_ID")
	private Long shciReferenceId;

	@Column(name = "SHCI_N_RIAL_PRICE", scale = 6, precision = 18)
	private BigDecimal shciRialPrice;

	@Column(name = "SHCI_F_SELLER_CONTACT_ID", nullable = false)
	private Long shciSellerContactId;

	@Column(name = "SHCI_F_SHIPMENT_ID", nullable = false)
	private Long shciShipmentId;

	@Column(name = "SHCI_N_SUM_PRICE", nullable = false, scale = 6, precision = 18)
	private BigDecimal shciSumPrice;

	@Column(name = "SHCI_N_SUM_PRICE_WITH_DISCOUNT", nullable = false, scale = 6, precision = 18)
	private BigDecimal shciSumPriceWithDiscount;

	@Column(name = "SHCI_N_SUM_PRICE_WITH_VAT", nullable = false, scale = 6, precision = 18)
	private BigDecimal shciSumPriceWithVat;

	@Column(name = "SHCI_N_T_VAT", nullable = false, scale = 5, precision = 10)
	private BigDecimal shciTVat;

	@Column(name = "IT_ID")
	private String itId;

	@Column(name = "IT_TITLE", nullable = false, length = 80)
	private String itTitle;

	@Column(name = "CR_ID")
	private String crId;

	@Column(name = "CR_N_REFERENCE", nullable = false)
	private RateReference crReference;

	@Column(name = "CR_D_CURRENCY_DATE", nullable = false)
	private Date crCurrencyDate;

	@Column(name = "CR_N_CURRENCY_RATE_VALUE", scale = 2, precision = 10, nullable = false)
	private BigDecimal crCurrencyRateValue;

	@Column(name = "CR_N_CURRENCY_TYPE_FROM")
	private CurrencyType crCurrencyTypeFrom;

	@Column(name = "CR_N_CURRENCY_TYPE_TO")
	private CurrencyType crCurrencyTypeTo;

	@Column(name = "SC_ID")
	private String scId;

	@Column(name = "SC_C_FULLNAME_EN", length = 1000)
	private String scNameEN;

	@Column(name = "SC_C_NATIONAL_CODE")
	private String scNationalCode;

	@Column(name = "SC_C_ACC_DETAIL")
	private String scAccDetail;

	@Column(name = "SC_C_REGISTER_NUMBER")
	private String scRegisterNumber;

	@Column(name = "SC_C_POSTAL_CODE")
	private String scPostalCode;

	@Column(name = "SC_C_TYPE")
	private Boolean scType;

	@Column(name = "SC_C_PHONE")
	private String scPhone;

	@Column(name = "SC_C_FAX")
	private String scFax;

	@Column(name = "SC_C_FULLNAME_FA", nullable = false, length = 1000)
	private String scNameFA;

	@Column(name = "SC_C_ECONOMICAL_CODE")
	private String scEconomicalCode;

	@Column(name = "SC_C_MOBILE")
	private String scMobile;

	@Column(name = "SC_C_TRADE_MARK")
	private String scTradeMark;

	@Column(name = "SC_C_CEO")
	private String scCeo;

	@Column(name = "SC_C_BRANCH_NAME")
	private String scBranchName;

	@Column(name = "SC_C_ACC_DETAIL_ID")
	private Long scAccDetailId;

	@Column(name = "SC_C_EMAIL")
	private String scEmail;

	@Column(name = "SC_C_COMMERCIAL_REGISTRATION")
	private String scCommercialRegistration;

	@Column(name = "BC_ID")
	private String bcId;

	@Column(name = "BC_C_FULLNAME_EN", length = 1000)
	private String bcNameEN;

	@Column(name = "BC_C_NATIONAL_CODE")
	private String bcNationalCode;

	@Column(name = "BC_C_ACC_DETAIL")
	private String bcAccDetail;

	@Column(name = "BC_C_REGISTER_NUMBER")
	private String bcRegisterNumber;

	@Column(name = "BC_C_POSTAL_CODE")
	private String bcPostalCode;

	@Column(name = "BC_C_TYPE")
	private Boolean bcType;

	@Column(name = "BC_C_PHONE")
	private String bcPhone;

	@Column(name = "BC_C_FAX")
	private String bcFax;

	@Column(name = "BC_C_FULLNAME_FA", nullable = false, length = 1000)
	private String bcNameFA;

	@Column(name = "BC_C_ECONOMICAL_CODE")
	private String bcEconomicalCode;

	@Column(name = "BC_C_MOBILE")
	private String bcMobile;

	@Column(name = "BC_C_TRADE_MARK")
	private String bcTradeMark;

	@Column(name = "BC_C_CEO")
	private String bcCeo;

	@Column(name = "BC_C_BRANCH_NAME")
	private String bcBranchName;

	@Column(name = "BC_C_ACC_DETAIL_ID")
	private Long bcAccDetailId;

	@Column(name = "BC_C_EMAIL")
	private String bcEmail;

	@Column(name = "BC_C_COMMERCIAL_REGISTRATION")
	private String bcCommercialRegistration;

	@Column(name = "U_ID")
	private String uId;

	@Column(name = "U_N_CATEGORY_UNIT")
	private CategoryUnit uCategoryUnit;

	@Column(name = "U_C_NAME_EN", nullable = false)
	private String uNameEN;

	@Column(name = "U_C_NAME_FA", nullable = false)
	private String uNameFA;

	@Column(name = "U_N_SYMBOL_UNIT")
	private SymbolUnit uSymbolUnit;

	@Column(name = "SHCID_N_C_VAT_PRICE", nullable = false, scale = 6, precision = 18)
	private BigDecimal shcidCVatPrice;

	@Column(name = "SHCID_N_DISCOUNT_PRICE", nullable = false, scale = 6, precision = 18)
	private BigDecimal shcidDiscountPrice;

	@Column(name = "SHCID_N_QUANTITY", nullable = false, scale = 5, precision = 10)
	private BigDecimal shcidQuantity;

	@Column(name = "SHCID_F_SHIPMENT_COST_DUTY_ID", nullable = false)
	private BigDecimal shcidShipmentCostDutyId;

	@Column(name = "SHCID_F_SHIPMENT_COST_INVOICE_ID", nullable = false)
	private BigDecimal shcidShipmentCostInvoiceId;

	@Column(name = "SHCID_N_SUM_PRICE", nullable = false, scale = 6, precision = 18)
	private BigDecimal shcidSumPrice;

	@Column(name = "SHCID_N_SUM_PRICE_WITH_DISCOUNT", nullable = false, scale = 6, precision = 18)
	private BigDecimal shcidSumPriceWithDiscount;

	@Column(name = "SHCID_N_SUM_PRICE_WITH_VAT", nullable = false, scale = 6, precision = 18)
	private BigDecimal shcidSumPriceWithVat;

	@Column(name = "SHCID_N_SUM_VAT_PRICE", nullable = false, scale = 6, precision = 18)
	private BigDecimal shcidSumVatPrice;

	@Column(name = "SHCID_N_T_VAT_PRICE", nullable = false, scale = 6, precision = 18)
	private BigDecimal shcidTVatPrice;

	@Column(name = "SHCID_F_UNIT_ID", nullable = false)
	private Long shcidUnitId;

	@Column(name = "SHCID_N_UNIT_PRICE", nullable = false, scale = 6, precision = 18)
	private BigDecimal shcidUnitPrice;

	@Column(name = "SHCD_ID")
	private String shcdId;

	@Column(name = "SHCD_C_CODE", nullable = false)
	private String shcdCode;

	@Column(name = "SHCD_C_NAME_EN", nullable = false)
	private String shcdNameEN;

	@Column(name = "SHCD_C_NAME_FA", nullable = false)
	private String shcdNameFA;

	@Getter
	@Setter
	@Accessors(chain = true)
	@Embeddable
	public static class CostInvoiceId implements Serializable {

		@Column(name = "SHCI_ID", nullable = false)
		private Long shciId;

		@Column(name = "SHCID_ID", nullable = false)
		private Long shcidId;

		@Override
		public boolean equals(Object o) {
			if (this == o) return true;
			if (!(o instanceof ViewCostInvoiceDocument.CostInvoiceId)) return false;
			ViewCostInvoiceDocument.CostInvoiceId that = (ViewCostInvoiceDocument.CostInvoiceId) o;
			return Objects.equals(getShciId(), that.getShciId()) &&
					Objects.equals(getShcidId(), that.getShcidId());
		}

		@Override
		public int hashCode() {
			return Objects.hash(getShciId(), getShcidId());
		}
	}
}
