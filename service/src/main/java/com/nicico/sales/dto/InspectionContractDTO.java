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
public class InspectionContractDTO {

	private ShipmentDTO.Info shipment;
	private Long shipmentId;
	private ContactDTO.Info contactByInspection;
	private Long contactByInspectionId;
	private ShipmentContractDTO.Info shipmentContract;
	private Long shipmentContractId;
	private String description;
	private String closeDate;
	private String createDate;
	private Long createUser;
	private String emailType;
	private String status;
	private String emailSubject;
	private String emailTo;
	private String emailCC;
	private String emailBody;
	private String emailRespond;
	private String vesselName;
	private Boolean superviseWeighing;
	private Boolean sampling;
	private Boolean moistureDetermination;

	@Getter
	@Setter
	@Accessors(chain = true)
	@ApiModel("InspectionContractInfo")
	public static class Info extends InspectionContractDTO {
		private Long id;
		private Date createdDate;
		private String createdBy;
		private Date lastModifiedDate;
		private String lastModifiedBy;
		private Integer version;

		private PortDTO.PortInfoTuple portByLoading;
		private PortDTO.PortInfoTuple portByDischarge;
	}

	@Getter
	@Setter
	@Accessors(chain = true)
	@ApiModel("InspectionContractCreateRq")
	public static class Create extends InspectionContractDTO {
	}

	@Getter
	@Setter
	@Accessors(chain = true)
	@ApiModel("InspectionContractUpdateRq")
	public static class Update extends InspectionContractDTO {
		@NotNull
		@ApiModelProperty(required = true)
		private Long id;
	}

	@Getter
	@Setter
	@Accessors(chain = true)
	@ApiModel("InspectionContractDeleteRq")
	public static class Delete {
		@NotNull
		@ApiModelProperty(required = true)
		private List<Long> ids;
	}

	@Getter
	@Setter
	@Accessors(chain = true)
	@JsonInclude(JsonInclude.Include.NON_NULL)
	public static class SpecRs {
		private List<InspectionContractDTO.Info> data;
		private Integer status;
		private Integer startRow;
		private Integer endRow;
		private Integer totalRows;
	}
}
