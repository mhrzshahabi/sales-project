package com.nicico.sales.dto;

import com.fasterxml.jackson.annotation.JsonInclude;
import com.nicico.sales.model.entities.base.ShipmentHeader;
import com.nicico.sales.model.entities.base.ShipmentResource;
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
public class ShipmentInquiryDTO {
	private ShipmentHeader shipmentHeader;
	@NotNull
	@ApiModelProperty(required = true)
	private Long shipmentHeaderId;
	private ShipmentResource shipmentResource;
	private Long shipmentResourceId;
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

	// ------------------------------

	@Getter
	@Setter
	@Accessors(chain = true)
	@ApiModel("ShipmentInquiryInfo")
	public static class Info extends ShipmentInquiryDTO {
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
	@ApiModel("ShipmentInquiryCreateRq")
	public static class Create extends ShipmentInquiryDTO {
	}

	// ------------------------------

	@Getter
	@Setter
	@Accessors(chain = true)
	@ApiModel("ShipmentInquiryUpdateRq")
	public static class Update extends ShipmentInquiryDTO {
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
	@ApiModel("ShipmentInquiryDeleteRq")
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
	@ApiModel("ShipmentInquirySpecRs")
	public static class ShipmentInquirySpecRs {
		private SpecRs response;
	}

	// ---------------

	@Getter
	@Setter
	@Accessors(chain = true)
	@JsonInclude(JsonInclude.Include.NON_NULL)
	public static class SpecRs {
		private List<ShipmentInquiryDTO.Info> data;
		private Integer status;
		private Integer startRow;
		private Integer endRow;
		private Integer totalRows;
	}
}
