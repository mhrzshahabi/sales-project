package com.nicico.sales.dto;

import com.fasterxml.jackson.annotation.JsonInclude;
import com.nicico.sales.model.entities.base.*;
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
public class ContractItemDTO {
	@NotNull
	@ApiModelProperty(required = true)
	private Contract contract;
	private Long itemRow;
	private Material tblMaterial;
	private Double amount;
	private Unit unit;
	private Double nbl;
	private String descl;
	private String isComplate;
	private String revisory;
	private Double tolorance;
	private String optional;
	private Long packSize;
	private Rate rate;
	private Contact tblContactByInspection;
	private String priceRefrence;
	private String plant;

	@Getter
	@Setter
	@Accessors(chain = true)
	@ApiModel("ContractItemInfo")
	public static class Info extends ContractItemDTO {
		private Long id;
		private Date createdDate;
		private String createdBy;
		private Date lastModifiedDate;
		private String lastModifiedBy;
		private Integer version;
	}



	@Getter
	@Setter
	@Accessors(chain = true)
	@ApiModel("ContractItemCreateRq")
	public static class Create extends ContractItemDTO {
	}



	@Getter
	@Setter
	@Accessors(chain = true)
	@ApiModel("ContractItemUpdateRq")
	public static class Update extends ContractItemDTO {
		@NotNull
		@ApiModelProperty(required = true)
		private Long id;
		@NotNull
		@ApiModelProperty(required = true)
		private Integer version;
	}



	@Getter
	@Setter
	@Accessors(chain = true)
	@ApiModel("ContractItemDeleteRq")
	public static class Delete {
		@NotNull
		@ApiModelProperty(required = true)
		private List<Long> ids;
	}



	@Getter
	@Setter
	@Accessors(chain = true)
	@JsonInclude(JsonInclude.Include.NON_NULL)
	@ApiModel("ContractItemSpecRs")
	public static class ContractItemSpecRs {
		private SpecRs response;
	}

	// ---------------

	@Getter
	@Setter
	@Accessors(chain = true)
	@JsonInclude(JsonInclude.Include.NON_NULL)
	public static class SpecRs {
		private List<ContractItemDTO.Info> data;
		private Integer status;
		private Integer startRow;
		private Integer endRow;
		private Integer totalRows;
	}
}
