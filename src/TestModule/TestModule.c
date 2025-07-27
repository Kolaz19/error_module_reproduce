#include "TestModule.h"
#include <stdio.h>

ECS_SYSTEM_DECLARE(test_function);

void TestModuleImport(ecs_world_t *world) {
	ECS_MODULE(world, TestModule);

	ECS_SYSTEM_DEFINE(world, test_function, 0, 0);
}

void test_function(ecs_iter_t *it) {
	printf("This is a test!");
}
