package com.nicico.sales.dto;

import com.fasterxml.jackson.annotation.JsonInclude;
import com.nicico.sales.model.entities.base.Contract;
import com.nicico.sales.model.entities.base.ContractItem;
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
public class ContractItemAddendumDTO {
	@NotNull
	@ApiModelProperty(required = true)
	private String addendumDesc;
	private Contract contract;
	private Long contractId;
	private ContractItem contractItem;
	private Long contractItemId;

	@Getter
	@Setter
	@Accessors(chain = true)
	@ApiModel("ContractItemAddendumInfo")
	public static class Info extends ContractItemAddendumDTO {
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
	@ApiModel("ContractItemAddendumCreateRq")
	public static class Create extends ContractItemAddendumDTO {
	}

	// ------------------------------

	@Getter
	@Setter
	@Accessors(chain = true)
	@ApiModel("ContractItemAddendumUpdateRq")
	public static class Update extends ContractItemAddendumDTO {
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
	@ApiModel("ContractItemAddendumDeleteRq")
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
	@ApiModel("ContractItemAddendumSpecRs")
	public static class ContractItemAddendumSpecRs {
		private SpecRs response;
	}

	// ---------------

	@Getter
	@Setter
	@Accessors(chain = true)
	@JsonInclude(JsonInclude.Include.NON_NULL)
	public static class SpecRs {
		private List<ContractItemAddendumDTO.Info> data;
		private Integer status;
		private Integer startRow;
		private Integer endRow;
		private Integer totalRows;
	}
}
