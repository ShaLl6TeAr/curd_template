package ${packageName}.exception;

public class ${Model}NotFoundException extend Exception {

    public ${Model}NotFoundException(String id) {
        super("${model} not found, id: " + id);
    }
}