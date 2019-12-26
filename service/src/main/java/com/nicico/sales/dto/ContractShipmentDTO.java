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
public class ContractShipmentDTO {
	@NotNull
	@ApiModelProperty(required = true)
	private Long contractId;
	private String plan;
	private Long shipmentRow;
	private Long dischargeId;
	private String address;
	private Double amount;
	private String sendDate;
	private Long duration;
	private Long tolorance;




	@Getter
	@Setter
	@Accessors(chain = true)
	@ApiModel("ContractShipmentInfo")
	public static class Info extends ContractShipmentDTO {
		private Long id;
		private ContractDTO contract;
		private PortDTO discharge;
		private Date createdDate;
		private String createdBy;
		private Date lastModifiedDate;
		private String lastModifiedBy;
		private Integer version;
	}



	@Getter
	@Setter
	@Accessors(chain = true)
	@ApiModel("ContractShipmentCreateRq")
	public static class Create extends ContractShipmentDTO {
	}



	@Getter
	@Setter
	@Accessors(chain = true)
	@ApiModel("ContractShipmentUpdateRq")
	public static class Update extends ContractShipmentDTO {
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
	@ApiModel("ContractShipmentDeleteRq")
	public static class Delete {
		@NotNull
		@ApiModelProperty(required = true)
		private List<Long> ids;
	}



	@Getter
	@Setter
	@Accessors(chain = true)
	@JsonInclude(JsonInclude.Include.NON_NULL)
	@ApiModel("ContractShipmentSpecRs")
	public static class ContractShipmentSpecRs {
		private SpecRs response;
	}

	// ---------------

	@Getter
	@Setter
	@Accessors(chain = true)
	@JsonInclude(JsonInclude.Include.NON_NULL)
	public static class SpecRs {
		private List<ContractShipmentDTO.Info> data;
		private Integer status;
		private Integer startRow;
		private Integer endRow;
		private Integer totalRows;
	}
}
