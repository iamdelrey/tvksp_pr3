package tvksp.practices.item;

import tvksp.practices.dto.NewItemRequest;
import org.springframework.core.io.FileSystemResource;
import org.springframework.core.io.Resource;
import org.springframework.http.MediaType;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;
import jakarta.validation.Valid;

import java.io.File;
import java.util.List;

@RestController
@RequestMapping("/api")
public class ItemController {

    private final ItemRepository repo;

    public ItemController(ItemRepository repo) {
        this.repo = repo;
    }

    @PostMapping("/items")
    public Item add(@Valid @RequestBody NewItemRequest req) {
        return repo.save(new Item(req.getName()));
    }

    @GetMapping("/items")
    public List<Item> all() {
        return repo.findAll();
    }

    // 3) Получение фото герба РТУ МИРЭА
    @GetMapping(value = "/mirea/crest", produces = MediaType.IMAGE_PNG_VALUE)
    public ResponseEntity<Resource> crest() {
        // Файл кладем в образ в /app/assets/mirea_gerb.png во время сборки (wget в Dockerfile)
        File f = new File("/app/assets/mirea_gerb.png");
        if (!f.exists()) {
            return ResponseEntity.notFound().build();
        }
        return ResponseEntity.ok(new FileSystemResource(f));
    }
}