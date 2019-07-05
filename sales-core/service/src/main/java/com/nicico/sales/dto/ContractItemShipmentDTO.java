package com.nicico.sales.dto;

import com.fasterxml.jackson.annotation.JsonInclude;
import com.nicico.sales.model.entities.base.ContractItem;
import com.nicico.sales.model.entities.base.Port;
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
public class ContractItemShipmentDTO {
	@NotNull
	@ApiModelProperty(required = true)
	private ContractItem contractItem;
	private Long contractItemId;
	private String plan;
	private Long shipmentRow;
	private Port port;
	private Long portId;
	private String address;
	private Double amount;
	private String sendDate;
	private Long duration;
	private Long tolorance;

	@Getter
	@Setter
	@Accessors(chain = true)
	@ApiModel("ContractItemShipmentInfo")
	public static class Info extends ContractItemShipmentDTO {
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
	@ApiModel("ContractItemShipmentCreateRq")
	public static class Create extends ContractItemShipmentDTO {
	}

	// ------------------------------

	@Getter
	@Setter
	@Accessors(chain = true)
	@ApiModel("ContractItemShipmentUpdateRq")
	public static class Update extends ContractItemShipmentDTO {
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
	@ApiModel("ContractItemShipmentDeleteRq")
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
	@ApiModel("ContractItemShipmentSpecRs")
	public static class ContractItemShipmentSpecRs {
		private SpecRs response;
	}

	// ---------------

	@Getter
	@Setter
	@Accessors(chain = true)
	@JsonInclude(JsonInclude.Include.NON_NULL)
	public static class SpecRs {
		private List<ContractItemShipmentDTO.Info> data;
		private Integer status;
		private Integer startRow;
		private Integer endRow;
		private Integer totalRows;
	}
}
