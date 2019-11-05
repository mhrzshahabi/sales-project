package com.nicico.sales.dto;

import com.fasterxml.jackson.annotation.JsonInclude;
import com.nicico.sales.model.entities.base.Material;
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
public class WarehouseLotDTO {
	@NotNull
	@ApiModelProperty(required = true)
	private String warehouseNo;
    @NotNull
	@ApiModelProperty(required = true)
	private Long materialId;
	private String plant;
	private String lotName;
	private Double cu;
	private Double ag;
	private Double au;
	private Double dmt;
	private Double mo;
	private Double si;
	private Double pb;
	private Double s;
	private Double c;
	private String p;
	private String size1;
	private Double size1Value;
	private String size2;
	private Double size2Value;
	private Double weightKg;
	private Double grossWeight;
	private Long contractId;
    private Boolean used;

	// ------------------------------

	@Getter
	@Setter
	@Accessors(chain = true)
	@ApiModel("WarehouseLotInfo")
	public static class Info extends WarehouseLotDTO {
		private Long id;
		private MaterialDTO.Info material;
		private Date createdDate;
		private String createdBy;
		private Date lastModifiedDate;
		private String lastModifiedBy;
		private Integer version;
		private ContactDTO.ContactInfoTuple contact;
	}

	// ------------------------------

	@Getter
	@Setter
	@Accessors(chain = true)
	@ApiModel("WarehouseLotCreateRq")
	public static class Create extends WarehouseLotDTO {
	}

	// ------------------------------

	@Getter
	@Setter
	@Accessors(chain = true)
	@ApiModel("WarehouseLotUpdateRq")
	public static class Update extends WarehouseLotDTO {
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
	@ApiModel("WarehouseLotDeleteRq")
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
	@ApiModel("WarehouseLotSpecRs")
	public static class WarehouseLotSpecRs {
		private SpecRs response;
	}

	// ---------------

	@Getter
	@Setter
	@Accessors(chain = true)
	@JsonInclude(JsonInclude.Include.NON_NULL)
	public static class SpecRs {
		private List<WarehouseLotDTO.Info> data;
		private Integer status;
		private Integer startRow;
		private Integer endRow;
		private Integer totalRows;
	}
}
