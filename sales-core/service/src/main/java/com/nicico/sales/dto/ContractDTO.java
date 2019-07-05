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
public class ContractDTO {
	private String contractNo;
	private String contractDate;
	private String isComplete;
	@NotNull
	@ApiModelProperty(required = true)
	private Long contactId;
	private Long incotermsId;
	private Long prepaid;
	private String prepaidCurrency;
	private String runFrom;
	private String runStartDate;
	private String runEndtDate;
	private String runTill;
	private Long materialId;
	private Double amount;
	private Long unitId;
	private Double premium;
	private Double discount;
	private Double treatCost;
	private Double refinaryCost;
	private Double gold;
	private Double goldTolorance;
	private Double silver;
	private Double silverTolorance;
	private Double copper;
	private Double copperTolorance;
	private Double molybdenum;
	private Double molybdenumTolorance;
	private String sideContractNo;
	private String sideContractDate;

	//------------------------------------------------------
	@Getter
	@Setter
	@ApiModel("ContractInfoTuple")
	public static class ContractInfoTuple {
		private String contractNo;
		private String contractDate;
		private ContactDTO.ContactInfoTuple contact;
	}
	//------------------------------------------------------

	@Getter
	@Setter
	@Accessors(chain = true)
	@ApiModel("ContractInfo")
	public static class Info extends ContractDTO {
		private UnitDTO unit;
		private MaterialDTO material;
		private ContactDTO contact;
		private IncotermsDTO incoterms;
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
	@ApiModel("ContractCreateRq")
	public static class Create extends ContractDTO {
	}

	// ------------------------------

	@Getter
	@Setter
	@Accessors(chain = true)
	@ApiModel("ContractUpdateRq")
	public static class Update extends ContractDTO {
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
	@ApiModel("ContractDeleteRq")
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
	@ApiModel("ContractSpecRs")
	public static class ContractSpecRs {
		private SpecRs response;
	}

	// ---------------

	@Getter
	@Setter
	@Accessors(chain = true)
	@JsonInclude(JsonInclude.Include.NON_NULL)
	public static class SpecRs {
		private List<ContractDTO.Info> data;
		private Integer status;
		private Integer startRow;
		private Integer endRow;
		private Integer totalRows;
	}
}
