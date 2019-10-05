package com.nicico.sales.dto;

import com.fasterxml.jackson.annotation.JsonInclude;
import io.swagger.annotations.ApiModel;
import io.swagger.annotations.ApiModelProperty;
import lombok.Getter;
import lombok.Setter;
import lombok.experimental.Accessors;

import javax.validation.constraints.NotNull;
import java.util.Date;
import java.util.List;

@Getter
@Setter
@Accessors(chain = true)
@JsonInclude(JsonInclude.Include.NON_NULL)
public class InvoiceInternalDTO {
	@NotNull
	@ApiModelProperty(required = true)
	private Long id;
	private String invId;
	private String lcId;
	private String havalehId;
	private String invDate;
	private String buyerId;
	private String customerId;
	private Long goodId;
	private Float invOtherKosorat;
	private String havFinalDate;
	private Float weightReal;
	private Float ghematUnit;
	private Float totalKosorat;
	private Float mablaghKol;
	private String shomarehSoratHesab;
	private Float payForAvarezMalyat;
	private Float payForAvarezAlayandegi;
	private String invSented;
	private Long typeForosh;
	private Long haveAlayandegi;
	private String codeNosaAlayandegi;
	private String markazHazineAlayandegi;
	private Long haveMalyat;
	private String codeNosaMalyat;
	private String markazHazineMalyat;
	private String codeNosaBank;
	private String codeNosaCustomer;
	private String codeEtebarNosaCustomer;
	private String codeMarkazHazineCustomer;
	private String codeMarkazHazineHlc;
	private String codeNosaMahsol;
	private String codeMarkazHazineMahsol;
	private String bankGroupDesc;
	private String customerName;
	private String gdsName;
	private String groupGoodsNosa;
	private String groupGoodName;
	private String lcDateSarReceid;

	// ------------------------------

	@Getter
	@Setter
	@Accessors(chain = true)
	@ApiModel("InvoiceInternalInfo")
	public static class Info extends InvoiceInternalDTO {
		private Long id;
		private Date createdDate;
		private String createdBy;
		private Date lastModifiedDate;
		private String lastModifiedBy;
		private Integer version;
	}

	// ------------------------------

	@Getter
	@Setter
	@Accessors(chain = true)
	@ApiModel("InvoiceInternalCreateRq")
	public static class Create extends InvoiceInternalDTO {
	}

	// ------------------------------

	@Getter
	@Setter
	@Accessors(chain = true)
	@ApiModel("InvoiceInternalUpdateRq")
	public static class Update extends InvoiceInternalDTO {
		@NotNull
		@ApiModelProperty(required = true)
		private Long id;
		@NotNull
		@ApiModelProperty(required = true)
		private Integer version;
	}

	// ------------------------------

	@Getter
	@Setter
	@Accessors(chain = true)
	@ApiModel("InvoiceInternalDeleteRq")
	public static class Delete {
		@NotNull
		@ApiModelProperty(required = true)
		private List<Long> ids;
	}

	// ------------------------------

	@Getter
	@Setter
	@Accessors(chain = true)
	@JsonInclude(JsonInclude.Include.NON_NULL)
	@ApiModel("InvoiceInternalSpecRs")
	public static class InvoiceSpecRs {
		private SpecRs response;
	}

	// ---------------

	@Getter
	@Setter
	@Accessors(chain = true)
	@JsonInclude(JsonInclude.Include.NON_NULL)
	public static class SpecRs {
		private List<InvoiceInternalDTO.Info> data;
		private Integer status;
		private Integer startRow;
		private Integer endRow;
		private Integer totalRows;
	}
}
