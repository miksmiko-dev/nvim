# 05 – Custom Snippets

## Current State

You have `LuaSnip` + `friendly-snippets` which gives you generic JS/TS snippets. Your stack
needs opinionated snippets for React components, NestJS boilerplate, Express routes, Prisma
schemas, and TypeORM entities.

---

## How to Add Custom Snippets

LuaSnip supports two formats. Since you load `friendly-snippets` with `from_vscode`, the
easiest approach is to add your own VSCode-style snippet JSON files.

### Step 1 — Create your snippets directory

```sh
mkdir -p ~/.config/nvim/snippets
```

### Step 2 — Register the directory in `lua-snippet.lua`

```lua
-- Modify lua/plugins/lua-snippet.lua
return {
  "L3MON4D3/LuaSnip",
  build = "make install_jsregexp",
  dependencies = { "rafamadriz/friendly-snippets" },
  config = function()
    require("luasnip.loaders.from_vscode").lazy_load()
    -- Load your custom snippets
    require("luasnip.loaders.from_vscode").lazy_load({
      paths = { vim.fn.stdpath("config") .. "/snippets" },
    })
  end,
}
```

### Step 3 — Create snippet files

---

## React / Next.js Snippets

**File: `~/.config/nvim/snippets/typescriptreact.json`**

```json
{
  "React Functional Component": {
    "prefix": "rfc",
    "body": [
      "import React from 'react'",
      "",
      "interface ${1:ComponentName}Props {",
      "  $2",
      "}",
      "",
      "export function ${1:ComponentName}({ $3 }: ${1:ComponentName}Props) {",
      "  return (",
      "    <div>",
      "      $0",
      "    </div>",
      "  )",
      "}",
      "",
      "export default ${1:ComponentName}"
    ],
    "description": "React functional component with TypeScript props"
  },
  "Next.js Page Component": {
    "prefix": "npage",
    "body": [
      "import type { NextPage } from 'next'",
      "",
      "const ${1:PageName}: NextPage = () => {",
      "  return (",
      "    <main>",
      "      $0",
      "    </main>",
      "  )",
      "}",
      "",
      "export default ${1:PageName}"
    ],
    "description": "Next.js page component"
  },
  "Next.js API Route (App Router)": {
    "prefix": "napr",
    "body": [
      "import { NextRequest, NextResponse } from 'next/server'",
      "",
      "export async function GET(request: NextRequest) {",
      "  try {",
      "    $0",
      "    return NextResponse.json({ data: null }, { status: 200 })",
      "  } catch (error) {",
      "    return NextResponse.json({ error: 'Internal Server Error' }, { status: 500 })",
      "  }",
      "}",
      "",
      "export async function POST(request: NextRequest) {",
      "  const body = await request.json()",
      "  try {",
      "    return NextResponse.json({ data: null }, { status: 201 })",
      "  } catch (error) {",
      "    return NextResponse.json({ error: 'Internal Server Error' }, { status: 500 })",
      "  }",
      "}"
    ],
    "description": "Next.js App Router API route handler"
  },
  "React useState hook": {
    "prefix": "us",
    "body": ["const [${1:state}, set${1/(.*)/${1:/capitalize}/}] = useState<${2:type}>(${3:initialValue})"],
    "description": "useState with TypeScript type"
  },
  "React useEffect hook": {
    "prefix": "ue",
    "body": [
      "useEffect(() => {",
      "  $1",
      "  return () => {",
      "    $2",
      "  }",
      "}, [$3])"
    ],
    "description": "useEffect with cleanup"
  },
  "React custom hook": {
    "prefix": "rhook",
    "body": [
      "import { useState, useEffect } from 'react'",
      "",
      "export function use${1:HookName}($2) {",
      "  $0",
      "  return {",
      "    ",
      "  }",
      "}"
    ],
    "description": "Custom React hook"
  }
}
```

---

## NestJS Snippets

**File: `~/.config/nvim/snippets/typescript.json`**

```json
{
  "NestJS Controller": {
    "prefix": "nctrl",
    "body": [
      "import { Controller, Get, Post, Body, Param, Delete, Put } from '@nestjs/common'",
      "import { ${1:Resource}Service } from './${2:resource}.service'",
      "",
      "@Controller('${3:resource}')",
      "export class ${1:Resource}Controller {",
      "  constructor(private readonly ${4:resource}Service: ${1:Resource}Service) {}",
      "",
      "  @Get()",
      "  findAll() {",
      "    return this.${4:resource}Service.findAll()",
      "  }",
      "",
      "  @Get(':id')",
      "  findOne(@Param('id') id: string) {",
      "    return this.${4:resource}Service.findOne(+id)",
      "  }",
      "",
      "  @Post()",
      "  create(@Body() createDto: $0) {",
      "    return this.${4:resource}Service.create(createDto)",
      "  }",
      "",
      "  @Put(':id')",
      "  update(@Param('id') id: string, @Body() updateDto: any) {",
      "    return this.${4:resource}Service.update(+id, updateDto)",
      "  }",
      "",
      "  @Delete(':id')",
      "  remove(@Param('id') id: string) {",
      "    return this.${4:resource}Service.remove(+id)",
      "  }",
      "}"
    ],
    "description": "NestJS CRUD controller"
  },
  "NestJS Service": {
    "prefix": "nsvc",
    "body": [
      "import { Injectable, NotFoundException } from '@nestjs/common'",
      "",
      "@Injectable()",
      "export class ${1:Resource}Service {",
      "  async findAll() {",
      "    $0",
      "  }",
      "",
      "  async findOne(id: number) {",
      "    ",
      "  }",
      "",
      "  async create(createDto: any) {",
      "    ",
      "  }",
      "",
      "  async update(id: number, updateDto: any) {",
      "    ",
      "  }",
      "",
      "  async remove(id: number) {",
      "    ",
      "  }",
      "}"
    ],
    "description": "NestJS service with CRUD stubs"
  },
  "NestJS Module": {
    "prefix": "nmod",
    "body": [
      "import { Module } from '@nestjs/common'",
      "import { ${1:Resource}Controller } from './${2:resource}.controller'",
      "import { ${1:Resource}Service } from './${2:resource}.service'",
      "",
      "@Module({",
      "  imports: [$3],",
      "  controllers: [${1:Resource}Controller],",
      "  providers: [${1:Resource}Service],",
      "  exports: [${1:Resource}Service],",
      "})",
      "export class ${1:Resource}Module {}"
    ],
    "description": "NestJS module"
  },
  "NestJS DTO": {
    "prefix": "ndto",
    "body": [
      "import { IsString, IsOptional, IsNumber } from 'class-validator'",
      "import { ApiProperty } from '@nestjs/swagger'",
      "",
      "export class ${1:Create}${2:Resource}Dto {",
      "  @ApiProperty()",
      "  @IsString()",
      "  ${3:field}: string",
      "",
      "  $0",
      "}"
    ],
    "description": "NestJS DTO with validation and Swagger decorators"
  },
  "Express Router": {
    "prefix": "exrouter",
    "body": [
      "import { Router, Request, Response, NextFunction } from 'express'",
      "",
      "const router = Router()",
      "",
      "router.get('/', async (req: Request, res: Response) => {",
      "  try {",
      "    $0",
      "    res.json({ data: null })",
      "  } catch (error) {",
      "    res.status(500).json({ error: 'Internal server error' })",
      "  }",
      "})",
      "",
      "export default router"
    ],
    "description": "Express router with TypeScript"
  },
  "Express Middleware": {
    "prefix": "exmw",
    "body": [
      "import { Request, Response, NextFunction } from 'express'",
      "",
      "export function ${1:middlewareName}(req: Request, res: Response, next: NextFunction) {",
      "  $0",
      "  next()",
      "}"
    ],
    "description": "Express middleware function"
  },
  "TypeORM Entity": {
    "prefix": "torm",
    "body": [
      "import { Entity, PrimaryGeneratedColumn, Column, CreateDateColumn, UpdateDateColumn } from 'typeorm'",
      "",
      "@Entity('${1:table_name}')",
      "export class ${2:EntityName} {",
      "  @PrimaryGeneratedColumn()",
      "  id: number",
      "",
      "  @Column()",
      "  ${3:field}: ${4:string}",
      "",
      "  @CreateDateColumn()",
      "  createdAt: Date",
      "",
      "  @UpdateDateColumn()",
      "  updatedAt: Date",
      "",
      "  $0",
      "}"
    ],
    "description": "TypeORM entity class"
  },
  "TypeORM Repository method": {
    "prefix": "trepo",
    "body": [
      "async ${1:methodName}(): Promise<${2:ReturnType}> {",
      "  return this.${3:entityName}Repository",
      "    .createQueryBuilder('${4:alias}')",
      "    .${0}",
      "    .getMany()",
      "}"
    ],
    "description": "TypeORM repository method with QueryBuilder"
  },
  "async try-catch": {
    "prefix": "atc",
    "body": [
      "try {",
      "  $1",
      "} catch (error) {",
      "  ${2:console.error(error)}",
      "  throw error",
      "}"
    ],
    "description": "Async try-catch block"
  }
}
```

---

## Prisma Snippets

**File: `~/.config/nvim/snippets/prisma.json`**

```json
{
  "Prisma Model": {
    "prefix": "model",
    "body": [
      "model ${1:ModelName} {",
      "  id        Int      @id @default(autoincrement())",
      "  createdAt DateTime @default(now())",
      "  updatedAt DateTime @updatedAt",
      "",
      "  ${2:field} ${3:String}",
      "",
      "  @@map(\"${4:table_name}\")",
      "}"
    ],
    "description": "Prisma model with timestamps"
  },
  "Prisma Relation (one-to-many)": {
    "prefix": "prelation",
    "body": [
      "${1:relatedModel}   ${2:RelatedModel}[] @relation(\"${3:relationName}\")"
    ],
    "description": "Prisma one-to-many relation field"
  }
}
```

---

## Tips

- After creating snippet files, reload with `:Lazy reload LuaSnip` or restart Neovim
- Test snippets: type the prefix and press `<Tab>` (or your completion trigger) to expand
- Jump between snippet placeholders with `<Tab>` / `<S-Tab>` (LuaSnip defaults)
- You can see all available snippets with `:lua require('luasnip').available()`
