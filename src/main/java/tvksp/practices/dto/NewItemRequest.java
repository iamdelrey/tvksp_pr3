package tvksp.practices.dto;

import jakarta.validation.constraints.NotBlank;

public class NewItemRequest {
    @NotBlank
    private String name;

    public NewItemRequest() {}

    public NewItemRequest(String name) { this.name = name; }

    public String getName() { return name; }
    public void setName(String name) { this.name = name; }
}