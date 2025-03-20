package com.company;

public class TypeQuestion {
    private int typeId;
    private String typeName;

    public TypeQuestion() {
    }

    public TypeQuestion(int typeId, String typeName) {
        this.typeId = typeId;
        this.typeName = typeName;
    }

    public int getTypeId() {
        return typeId;
    }

    public void setTypeId(int typeId) {
        this.typeId = typeId;
    }

    public String getTypeName() {
        return typeName;
    }

    public void setTypeName(String typeName) {
        this.typeName = typeName;
    }

@Override
    public String toString() {
        return "TypeQuestion{" +
                "typeId=" + typeId +
                ", typeName='" + typeName + '\'' +
                '}';
    }
}
