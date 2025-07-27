#include "flecs.h"
#include "TestModule/TestModule.h"


int main(int argc, char *argv[]) {

    ecs_world_t *ecs_world = ecs_init();
    ECS_IMPORT(ecs_world, TestModule);
	ecs_run(ecs_world, test_function, 0, 0);

	//This works
	//ecs_run(ecs_world, ecs_lookup(ecs_world, "test.module.test_function"), 0, 0);

    ecs_fini(ecs_world);
}
