#ifndef TEST_MODULE_H
#define TEST_MODULE_H

#include "flecs.h"

void test_function(ecs_iter_t *it);
extern ECS_SYSTEM_DECLARE(test_function);
void TestModuleImport(ecs_world_t *world);

#endif
