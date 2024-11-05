//
//  main.m
//  lua
//
//  Created by pengweijian on 2017/10/17.
//  Copyright © 2017年 pengweijian. All rights reserved.
//

#import <Foundation/Foundation.h>
#include <lua.h>
#include <lauxlib.h>
#include <lualib.h>


int main(int argc, const char * argv[]) {
    @autoreleasepool {
        lua_State *L = luaL_newstate();
        luaL_openlibs(L);
        int ret = luaL_dofile(L, "/Users/pengweijian/MyDemos/lua/lua/demo.lua");
        NSLog(@"----%d",ret);
        luaL_loadstring(L, "local ab = 账上; print(5, ab);");
        lua_close(L);
    }
    return 0;
}
