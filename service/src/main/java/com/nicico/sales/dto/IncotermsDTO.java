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
public class IncotermsDTO {
	@NotNull
	@ApiModelProperty(required = true)
	private String code;
	private Boolean works;
	private Boolean carrier;
	private Boolean alongSideShip;
	private Boolean onBoard;
	private Boolean arrival;
	private Boolean terminal;
	private Boolean destination;
	private Boolean warehouse;
	private String expenses;
	private String namedPlace;
	private String namedPort;


	@Getter
	@Setter
	@Accessors(chain = true)
	@ApiModel("IncotermsInfo")
	public static class Info extends IncotermsDTO {
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
	@ApiModel("IncotermsCreateRq")
	public static class Create extends IncotermsDTO {
	}



	@Getter
	@Setter
	@Accessors(chain = true)
	@ApiModel("IncotermsUpdateRq")
	public static class Update extends IncotermsDTO {
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
	@ApiModel("IncotermsDeleteRq")
	public static class Delete {
		@NotNull
		@ApiModelProperty(required = true)
		private List<Long> ids;
	}



	@Getter
	@Setter
	@Accessors(chain = true)
	@JsonInclude(JsonInclude.Include.NON_NULL)
	@ApiModel("IncotermsSpecRs")
	public static class IncotermsSpecRs {
		private SpecRs response;
	}

	// ---------------

	@Getter
	@Setter
	@Accessors(chain = true)
	@JsonInclude(JsonInclude.Include.NON_NULL)
	public static class SpecRs {
		private List<IncotermsDTO.Info> data;
		private Integer status;
		private Integer startRow;
		private Integer endRow;
		private Integer totalRows;
	}
}
