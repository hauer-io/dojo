package io.hauer.demo.simple

import org.springframework.boot.autoconfigure.SpringBootApplication
import org.springframework.boot.runApplication
import org.springframework.web.bind.annotation.GetMapping
import org.springframework.web.bind.annotation.RestController

@RestController
@SpringBootApplication
class SimpleApplication {
    @GetMapping
    fun hello () = "Hello Workd"
}

fun main(args: Array<String>) {
    runApplication<SimpleApplication>(*args)
}
