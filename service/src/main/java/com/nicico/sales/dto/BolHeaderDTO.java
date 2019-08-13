package com.nicico.sales.dto;

import com.fasterxml.jackson.annotation.JsonInclude;
import com.nicico.sales.model.entities.base.Port;
import com.nicico.sales.model.entities.base.ShipmentContract;
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
public class BolHeaderDTO {
	@NotNull
	@ApiModelProperty(required = true)
	private com.nicico.sales.model.entities.base.Shipment Shipment;
	private Long shipmentId;
	private ShipmentContract shipmentContract;
	private Long shipmentContractId;
	private Double grossWeight;
	private Double netWeight;
	private Long noContainer;
	private Long noBundle;
	private String blNo;
	private String swBlNo;
	private Port portByDischarge;
	private Long PortByDischargeId;
	private Port switchPort;
	private Long switchPortId;
	private Long noPalete;
	private String bolDate;


	@Getter
	@Setter
	@Accessors(chain = true)
	@ApiModel("BolHeaderInfo")
	public static class Info extends BolHeaderDTO {
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
	@ApiModel("BolHeaderCreateRq")
	public static class Create extends BolHeaderDTO {
	}

	// ------------------------------

	@Getter
	@Setter
	@Accessors(chain = true)
	@ApiModel("BolHeaderUpdateRq")
	public static class Update extends BolHeaderDTO {
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
	@ApiModel("BolHeaderDeleteRq")
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
	@ApiModel("BolHeaderSpecRs")
	public static class BolHeaderSpecRs {
		private SpecRs response;
	}

	// ---------------

	@Getter
	@Setter
	@Accessors(chain = true)
	@JsonInclude(JsonInclude.Include.NON_NULL)
	public static class SpecRs {
		private List<BolHeaderDTO.Info> data;
		private Integer status;
		private Integer startRow;
		private Integer endRow;
		private Integer totalRows;
	}
}
