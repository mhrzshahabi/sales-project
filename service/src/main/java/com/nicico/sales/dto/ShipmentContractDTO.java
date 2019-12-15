package com.nicico.sales.dto;

import com.fasterxml.jackson.annotation.JsonInclude;
import com.nicico.sales.model.entities.base.Contact;
import com.nicico.sales.model.entities.base.Country;
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
public class ShipmentContractDTO {
	private Contact tblContactByOwners;
	@NotNull
	@ApiModelProperty(required = true)
//	private Long contactByOwnersId;
//	private Contact tblContactByCharterer;
//	private Long contactByChartererId;
//	private Contact tblContactByChainOfOwners;
//	private Long contactByChainOfOwnersId;
//	private Country tblCountryFlag;
//	private Long countryFlagId;
//	private Long shipmentHeaderId;
//	private Long shipmentPriceId;
//	private String shipmentContractDate;
	private String no;
	private Double capacity;
	private String laycanStart;
	private String laycanEnd;
	private String loadingRate;
	private String dischargeRate;
	private Double demurrage;
	private Double dispatch;
	private Double freight;
	private String bale;
	private String grain;
	private String grossWeight;
	private String vesselName;
	private String yearOfBuilt;
	private String imoNo;
	private String officialNo;
	private String loa;
	private String beam;
	private String cranes;
	private String holds;
	private String hatch;
	private String classType;
	private String weighingMethodes;
	private String shipFlag;
	private String createDate;


	// ------------------------------

	@Getter
	@Setter
	@Accessors(chain = true)
	@ApiModel("ShipmentContractInfo")
	public static class Info extends ShipmentContractDTO {
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
	@ApiModel("ShipmentContractCreateRq")
	public static class Create extends ShipmentContractDTO {
	}

	// ------------------------------

	@Getter
	@Setter
	@Accessors(chain = true)
	@ApiModel("ShipmentContractUpdateRq")
	public static class Update extends ShipmentContractDTO {
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
	@ApiModel("ShipmentContractDeleteRq")
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
	@ApiModel("ShipmentContractSpecRs")
	public static class ShipmentContractSpecRs {
		private SpecRs response;
	}

	// ---------------

	@Getter
	@Setter
	@Accessors(chain = true)
	@JsonInclude(JsonInclude.Include.NON_NULL)
	public static class SpecRs {
		private List<ShipmentContractDTO.Info> data;
		private Integer status;
		private Integer startRow;
		private Integer endRow;
		private Integer totalRows;
	}
}
