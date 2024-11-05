//
//  main.m
//  luaSrc
//
//  Created by pengweijian on 2017/10/17.
//  Copyright © 2017年 pengweijian. All rights reserved.
//

#import <Foundation/Foundation.h>
#include "lua.h"
#include "lauxlib.h"
#include "lualib.h"
#include "lobject.h"
#include "lstate.h"

void getVFromTable(lua_State *L, const char *tname, const char *key);
int _tmain();
int main(int argc, const char * argv[]) {
    @autoreleasepool {
        lua_State *L = luaL_newstate();
        luaL_openlibs(L);
        int ret = luaL_dofile(L, "/Users/pengweijian/Desktop/Demos/lua/lua/demo.lua");
        StkId ftk = L->stack, ltk = L->stack_last;

        getVFromTable(L, "helloTable", "name");
        lua_close(L);
        StkId top4 = L->top;
    }
    return 0;
    

}


void getVFromTable(lua_State *L, const char *tname, const char *key)
{
    StkId top = L->top;
    printf("lua_getglobal 前 top:%p\n", top);
    lua_getglobal(L, tname);
    top = L->top;
    printf("lua_getglobal 后 top:%p\n", top);
    
    lua_pushstring(L, key);
    top = L->top;
    printf("lua_pushstring 后 top:%p\n", top);
    lua_gettable(L, -2);
    top = L->top;
    printf("lua_gettable 后 top:%p\n", top);
    
    const char *c = lua_tostring(L, -1);
    top = L->top;
    printf("lua_tostring 后 top:%p\n", top);
    NSLog(@"---%s", c);
}

/**
 lua_getglobal(L, "helloTable"); 执行前
 ftk    StkId    0x1007642b0    0x00000001007642b0
 ltk    StkId    0x100764480    0x0000000100764480
 s    int    34
 top    StkId    0x1007642d0    0x00000001007642d0
 fc    StkId    0x1007642b0    0x00000001007642b0
 
 lua_getglobal(L, "helloTable"); 执行后
 ftk    StkId    0x1007642b0    0x00000001007642b0
 ltk    StkId    0x100764480    0x0000000100764480
 s    int    34
 top    StkId    0x1007642e0    0x00000001007642e0
 fc    StkId    0x1007642b0    0x00000001007642b0
 
 lua_pushstring(L, "name"); 执行后
 ftk    StkId    0x1007642b0    0x00000001007642b0
 ltk    StkId    0x100764480    0x0000000100764480
 s    int    34
 top    StkId    0x1007642f0    0x00000001007642f0
 fc    StkId    0x1007642b0    0x00000001007642b0
 */
