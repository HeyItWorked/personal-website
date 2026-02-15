import { defineCollection, z } from 'astro:content';

const blogCollection = defineCollection({
  type: 'content',
  schema: z.object({
    title: z.string(),
    description: z.string(),
    pubDate: z.date(),
    updatedDate: z.date().optional(),
    tags: z.array(z.string()),
    draft: z.boolean().default(false),
  }),
});

const projectsCollection = defineCollection({
  type: 'content',
  schema: z.object({
    title: z.string(),
    description: z.string(),
    techStack: z.array(z.string()),
    liveUrl: z.string().optional(),
    repoUrl: z.string().optional(),
    image: z.string().optional(),
    featured: z.boolean().default(false),
    type: z.enum(['professional', 'personal']),
  }),
});

const workCollection = defineCollection({
  type: 'content',
  schema: z.object({
    company: z.string(),
    role: z.string(),
    startDate: z.date(),
    endDate: z.date().optional(),
    achievements: z.array(z.string()),
    techStack: z.array(z.string()),
    logo: z.string().optional(),
  }),
});

const gardenCollection = defineCollection({
  type: 'content',
  schema: z.object({
    title: z.string(),
    description: z.string(),
    maturity: z.enum(['seedling', 'budding', 'evergreen']),
    tags: z.array(z.string()),
    links: z.array(z.string()).default([]),
  }),
});

export const collections = {
  blog: blogCollection,
  projects: projectsCollection,
  work: workCollection,
  garden: gardenCollection,
};
