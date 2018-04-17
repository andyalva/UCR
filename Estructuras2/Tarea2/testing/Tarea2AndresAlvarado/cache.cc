#include <stdlib.h>
#include <assert.h>
#include "cache.h"
using namespace std;

Cache::Cache(int s, int a, int b)
{
  ulong i, j;
  reads = readMisses = writes = 0;
  writeMisses = writeBacks = currentCycle = 0;

  size = (ulong)(s);
  lineSize = (ulong)(b);
  assoc = (ulong)(a);
  sets = (ulong)((s / b) / a);
  numLines = (ulong)(s / b);
  log2Sets = (ulong)(log2(sets));
  log2Blk = (ulong)(log2(b));

  num_of_cache_to_cache_transfer = 0;
  num_of_mem_trans = 0;
  num_of_interventions = 0;
  num_of_invalidations = 0;
  num_of_flushes = 0;

  tagMask = 0;
  for (i = 0; i < log2Sets; i++)
  {
    tagMask <<= 1;
    tagMask |= 1;
  }

  cache = new cacheLine *[sets];
  for (i = 0; i < sets; i++)
  {
    cache[i] = new cacheLine[assoc];
    for (j = 0; j < assoc; j++)
    {
      cache[i][j].invalidate();
    }
  }
}

void Cache::Access(ulong addr, uchar op)
{
  currentCycle++;

  if (op == 'S')
    writes++;
  else
    reads++;

  cacheLine *line = findLine(addr);
  if (line == NULL) //miss
  {
    if (op == 'S')
      writeMisses++;
    else
      readMisses++;

    cacheLine *newline = fillLine(addr);
    if (op == 'S')
      newline->setFlags(MODIFIED); //Pasa al estado modificado despues de la escritura
  }
  else
  {
    //Como hubo un hit se modifica a Modificado
    updateLRU(line);
    if (op == 'S')
      line->setFlags(SHARED);
  }
}

cacheLine *Cache::findLine(ulong addr)
{
  ulong i, j, tag, pos;

  pos = assoc;
  tag = calcTag(addr);
  i = calcIndex(addr);

  for (j = 0; j < assoc; j++)
    if (cache[i][j].isValid())
      if (cache[i][j].getTag() == tag)
      {
        pos = j;
        break;
      }
  if (pos == assoc)
    return NULL;
  else
    return &(cache[i][pos]);
}

void Cache::updateLRU(cacheLine *line)
{
  line->setSeq(currentCycle);
}

cacheLine *Cache::getLRU(ulong addr)
{
  ulong i, j, victim, min;

  victim = assoc;
  min = currentCycle;
  i = calcIndex(addr);

  for (j = 0; j < assoc; j++)
  {
    if (cache[i][j].isValid() == 0)
      return &(cache[i][j]);
  }
  for (j = 0; j < assoc; j++)
  {
    if (cache[i][j].getSeq() <= min)
    {
      victim = j;
      min = cache[i][j].getSeq();
    }
  }
  assert(victim != assoc);

  return &(cache[i][victim]);
}

cacheLine *Cache::findLineToReplace(ulong addr)
{
  cacheLine *victim = getLRU(addr);
  updateLRU(victim);

  return (victim);
}

// Agrega nueva linea
cacheLine *Cache::fillLine(ulong addr)
{
  ulong tag;

  cacheLine *victim = findLineToReplace(addr);
  assert(victim != 0);
  if (victim->getFlags() == MODIFIED || victim->getFlags() == SHARED_MODIFIED)
    writeBack(addr);

  tag = calcTag(addr);
  victim->setTag(tag);
  victim->setFlags(MODIFIED);

  return victim;
}

void Cache::printStats()
{
  //imprime las estadisticas obtenidas
}
